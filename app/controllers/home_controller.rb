class HomeController < ApplicationController

   # GET /home/index
   # GET /home/index.json
   def index
      @selected_projects = Project.selected_projects
   end
end
