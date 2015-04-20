require 'test_helper'

module LogInteractor
   extend ActiveSupport::Concern

   included do
      before do
         puts 'before Interactor'
      end

      after do
         puts 'after Interactor'
      end
   end
end

module Interactor
   module ContextAttributes
      def delegate_to_context(*attributes)
         delegate *attributes, to: :context
      end

      alias :receives :delegate_to_context

      def provides(*args)
         ;
      end
   end
end

module Interactor
   module PerformInTransaction
      def call
         begin
            ActiveRecord::Base.transaction do
               super
            end
         rescue => e
            transaction_rescue(e)
         end
      end

      def transaction_rescue e
         #puts("rolled back")
      end
   end
end

class Mailer
   attr_accessor :message

   def prepare_mail(mail_message)
      @message = mail_message
   end
end

class LowMailer < Mailer
   def prepare_mail(mail_message)
      @message = mail_message.downcase
   end
end

class DoStuff
   include Interactor
   include LogInteractor
   extend Interactor::ContextAttributes

   receives :action
   provides :status, :message

   def call
      context.status = "before"
      context.message = "okay"
      prepare_mail "Mail_message"

      context.fail! if context.action == "failure"
      context.status = "after"
   end

   def rollback
      puts "rollback 1"
   end

   private

   def prepare_mail(message)
      mailer.prepare_mail message
   end

   def mailer
      context.mailer ||= Mailer.new
   end
end

class DoProjectStuff
   include Interactor

   def call
      begin
         project = Project.create!(context.project_params)
         context.project = project
      rescue => e
         context.fail!
      end
   end

   def rollback
      context.project = nil
      puts "rollback 1"
   end
end

class DoProjectStuff2
   include Interactor
   extend Interactor::ContextAttributes

   receives :project_params2
   provides :project2

   def call
      begin
         project = Project.create!(project_params2)
         context.project2 = project
      rescue => e
         context.fail!
      end
   end

   def rollback
      context.project2 = nil
      puts "rollback 2"
   end
end

class PlaceOrder
   include Interactor::Organizer
   include Interactor::PerformInTransaction

   def transaction_rescue e
      puts("rolled back completely")
   end

   organize DoProjectStuff, DoProjectStuff2, DoStuff
end

class InteractorTest < ModelTest

   describe PlaceOrder, "PlaceOrder" do

      let(:project_params) { {name: "test1", summary: "test1", description: "test1", category: categories(:one)} }
      let(:project_params2) { {name: "test2", summary: "test2", description: "test2", category: categories(:one)} }
      let(:invalid_project_params) { {description: "bla_and_no_name"} }

      let(:mailer) { LowMailer.new }

      it "should create both projects" do
         result = PlaceOrder.call(action: "success", project_params: project_params, project_params2: project_params2,
            mailer: mailer)

         result.success?.must_equal true
         result.project.wont_be_nil
         result.project2.wont_be_nil
         result.mailer.message.must_equal "mail_message"

         Project.find_by_name(project_params[:name]).name.must_equal project_params[:name]
         Project.find_by_name(project_params2[:name]).name.must_equal project_params2[:name]
      end

      it "should rollback the transaction" do
         result = PlaceOrder.call(action: "failure", project_params: project_params, project_params2: project_params2,
                                  mailer: mailer)

         result.failure?.must_equal true
         result.project.must_be_nil
         result.project2.must_be_nil

         Project.find_by_name(project_params[:name]).must_be_nil
         Project.find_by_name(project_params2[:name]).must_be_nil
      end

      it "should again rollback the transaction" do
         result = PlaceOrder.call(action: "failure", project_params: project_params,
                                  project_params2: invalid_project_params, mailer: mailer)

         result.failure?.must_equal true
         result.project.must_be_nil
         result.project2.must_be_nil

         Project.find_by_name(project_params[:name]).must_be_nil
         Project.find_by_name(project_params2[:name]).must_be_nil
      end
   end

end
