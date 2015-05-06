class ProjectsController < ApplicationController
   before_action :set_project, only: [:show]

   respond_to :html

   # GET /home/index
   # GET /home/index.json
   def index
      @categories = Category.active_categories(I18n.locale.to_s.downcase)
      @selected_projects = Project.search_and_order(params[:text], params[:category], params[:order_by])

      respond_with(@selected_projects)
   end

   def show
      respond_with(@project)
   end

   private

   def set_project
      @project = Project.find(params[:id])
   end

end
