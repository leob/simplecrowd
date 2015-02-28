require 'test_helper'

class ArrayTest < ActiveSupport::TestCase

  describe Array do

    it "can be created with no arguments" do
      Array.new.must_be_instance_of Array
    end

    it "can be created with a specific size" do
      Array.new(10).size.must_equal 10
    end

    subject { ["a", "b"] }

    it "grows by 3 when adding 3 elements" do
      -> {
        subject << "c"
        subject << "d"
        subject << "e"
      }.must_change "subject.size", 3
    end

  end

end