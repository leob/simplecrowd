require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

   # turns out this isn't needed ...
   #tests ProjectsController

   describe Admin::ProjectsController do

      let(:project) { projects(:one) }

      # controller actions for which the user has to be signed in
      context "the user should be logged in first" do

         before do
            # sign_in users(:regular_user)
            sign_in users(:admin_user)
         end

         it "should get new" do
            get :new

            must_respond_with :success
            must_render_template "new"
         end

      #    it "should create valid project" do
      #       -> {
      #          post :create, project: {name: project.name, summary: project.summary, description: project.description}
      #       }.must_change 'Project.count'
      #
      #       must_redirect_to project_path(assigns(:project))
      #    end
      #
      #    it "should not create invalid project" do
      #       # try to create an invalid project: no name given
      #       -> {
      #          post :create, project: {description: project.description}
      #       }.wont_change 'Project.count'
      #
      #       # this should result in form validation errors (Bootstrap class "form-errors")
      #       must_select "div:match('class', ?)", /form-errors/
      #    end
      #
      #    it "should get edit" do
      #       get :edit, id: project
      #
      #       must_respond_with :success
      #       must_render_template "edit"
      #    end
      #
      #    it "should update project" do
      #       patch :update, id: project, project:
      #                        {description: project.description, editor_pick: project.editor_pick, name: project.name}
      #
      #       must_redirect_to project_path(assigns(:project))
      #    end
      #
      #    # it "should destroy project" do
      #    #   assert_difference('Project.count', -1) do
      #    #     delete :destroy, id: project
      #    #   end
      #    #
      #    #   assert_redirected_to projects_path
      #    # end
      # # end
      # #
      # # # controller actions for which the user doesn't have to be signed in
      # # context "the user does not have to be logged in" do
      #
      #    it "should get index" do
      #       get :index
      #
      #       must_respond_with :success
      #       wont_be_nil assigns(:projects)
      #       must_render_template "index"
      #    end
      #
      #    it "should show project" do
      #       get :show, id: project
      #
      #       must_respond_with :success
      #       must_render_template "show"
      #    end

      end
   end

end
