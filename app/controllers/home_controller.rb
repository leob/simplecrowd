class HomeController < ApplicationController

   # GET /home/index
   # GET /home/index.json
   def index
      @selected_projects = Project.selected_projects
      @categories = Category.active_categories(I18n.locale.to_s.downcase)
   end
end
