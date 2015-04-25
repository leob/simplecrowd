class ProjectsController < ApplicationController

   # GET /home/index
   # GET /home/index.json
   def index
      @categories = Category.active_categories(I18n.locale.to_s.downcase)
      @selected_projects = Project.search_and_order(params[:text], params[:category], params[:order_by])
   end
end
