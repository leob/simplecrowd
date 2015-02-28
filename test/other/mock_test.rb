require 'test_helper'

class MockTest < ActiveSupport::TestCase

  describe "mocks" do

    it "tests a mock duck" do
      duck = mock('duck')
      duck.expects(:quack)
      duck.quack
    end

    it "tests a big mock duck" do
      duck = mock('duck')
      duck.expects(:swim).with(anything, 2)
      duck.swim(1, 2)
    end

    it "tests a stub duck" do
      donald = Object.new
      donald.stubs(:flap_wings).returns(true)

      donald.flap_wings
      donald.flap_wings
    end

    it "tests a mock stub duck" do
      donald = mock("duck")
      donald.stubs(:flap_wings).returns(true)

      donald.flap_wings
      donald.flap_wings
    end

  end

end