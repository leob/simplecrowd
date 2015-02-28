class ProjectsController < ApplicationController
   #before_action :set_project, only: [:show, :edit, :update, :destroy]
   before_action :set_project, only: [:show, :edit, :update]
   before_action :authenticate_user!, only: [:new, :edit, :create, :update]
   before_action :set_title

   respond_to :html

   def index
      @projects = Project.all
      respond_with(@projects)
   end

   def show
      respond_with(@project)
   end

   def new
      @project = Project.new
      respond_with(@project)
   end

   def edit
   end

   def create
      @project = Project.new(project_params)
      @project.save
      respond_with(@project)
   end

   def update
      @project.update(project_params)
      respond_with(@project)
   end

   # def destroy
   #   @project.destroy
   #   respond_with(@project)
   # end

   private

   def set_title
      page_title("forms.projects.title")
   end

   def set_project
      @project = Project.find(params[:id])
   end

   def project_params
      params.require(:project).permit(:name, :summary, :description, :target_amount, :collected_amount, :main_image,
                                      :editor_pick)
   end
end
