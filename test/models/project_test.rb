require 'test_helper'

class ProjectTest < ModelTest

   describe Project, "Demonstration of MiniTest" do

      let(:project_params) { { name: "test1", summary: "test1", description: "test1" } }
      subject { Project.new project_params }

      it "is valid with valid params" do
         subject.must_be :valid?
      end

      it "is invalid without a description" do
         project_params.delete :description

         subject.wont_be :valid?

         subject.errors[:description].must_be :present?
         subject.errors[:name].wont_be :present?
      end

      it "is valid with a description" do
         subject.must_be :valid?

         subject.errors[:description].wont_be :present?
      end

      it "should be able to find a product" do
         mock_project = Project.new
         Project.expects(:find).with(1).returns(mock_project)
         mock_project.must_equal Project.find(1)
      end

      it "has a project 'one'" do
         projects(:one).name.must_equal "One"
      end

      it "can find all projects" do
         projects = Project.order(:name)
         projects.size.must_equal 2
         projects.first.name.must_equal "One"
      end

      it "can find all editor's picks" do
         projects = Project.where(editor_pick: true)
         projects.size.must_equal 1
         projects.first.name.must_equal "Two"
      end

   end

end