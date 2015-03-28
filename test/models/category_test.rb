require "test_helper"

describe Category do
  let(:category) { Category.new }

  it "must be valid" do
    category.must_be :valid?
  end
end
