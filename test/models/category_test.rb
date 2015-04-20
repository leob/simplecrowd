require "test_helper"

describe Category do
   let(:category) { Category.new }

   it "must be valid" do
      # '_()' is the new Minitest syntax recommended by http://blog.zenspider.com/blog/2015/04/great-expectations.html
      _(category).must_be :valid?
   end
end
