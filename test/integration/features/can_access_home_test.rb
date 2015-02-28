require "test_helper"

feature "CanAccessHome" do
  scenario "the test is sound" do
    visit root_path

#save_and_open_page
#print page.html

    page.must_have_content "the crowdfunding network"

    page.wont_have_content "Hello World"
    page.wont_have_content "Goobye All!"
  end
end
