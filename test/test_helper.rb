ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)

require "rails/test_help"

require "minitest/rails"
require "minitest/rails/capybara"
# Uncomment for awesome colorful output:
require "minitest/pride"
require "minitest/reporters"
require 'mocha/mini_test'

Minitest::Reporters.use!(
    Minitest::Reporters::SpecReporter.new,
    ENV,
    Minitest.backtrace_filter
)

class ModelTest < ActiveSupport::TestCase
   ActiveRecord::Migration.check_pending!
   # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order. Note: You'll currently still
   # have to declare fixtures explicitly in integration tests -- they do not yet inherit this setting
   fixtures :all

   # optional - see: http://blowmage.com/2013/07/08/minitest-spec-rails4
   #register_spec_type self do |desc|
   #   desc < ActiveRecord::Base if desc.is_a? Class
   #end
end

# enables us to use Devise helpers in our controller tests (we need them ONLY in controller tests)
class ActionController::TestCase
   include Devise::TestHelpers
   # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order. Note: You'll currently still
   # have to declare fixtures explicitly in integration tests -- they do not yet inherit this setting
   fixtures :all

   # ability to use RSpec-like 'context' - see: http://blog.crowdint.com/2013/06/14/testing-rails-with-minitest.html
   class << self
      alias :context :describe
   end
end

# enables us to use Capybara DSL in integration tests
class ActionDispatch::IntegrationTest
   include Capybara::DSL
end


# Add extra expectations - trick from http://blowmage.com/2013/07/08/minitest-spec-rails4
#module MyApp::Expectations
#   infect_an_assertion :assert_difference, :must_change
#   infect_an_assertion :assert_no_difference, :wont_change
#end

# add the extra expectations
#class Object
#   include MyApp::Expectations
#end

#
# Decrease Devise overhead: http://www.rubyinside.com/careful-cutting-to-get-faster-rspec-runs-with-rails-5207.html
#
# Don't need passwords in test DB to be secure, but we would like 'em to be
# fast -- and the stretches mechanism is intended to make passwords
# computationally expensive.
# module Devise
#    module Models
#       module DatabaseAuthenticatable
#          protected
#
#          def password_digest(password)
#             password
#          end
#       end
#    end
# end
# Devise.setup do |config|
#    config.stretches = 0
# end
