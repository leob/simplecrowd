require 'rails_helper'

RSpec.describe "projects/edit", :type => :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :name => "MyString",
      :description => "MyText",
      :editor_pick => false
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input#project_name[name=?]", "project[name]"

      assert_select "textarea#project_description[name=?]", "project[description]"

      assert_select "input#project_editor_pick[name=?]", "project[editor_pick]"
    end
  end
end
