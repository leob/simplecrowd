class HomeController < ApplicationController

   # GET /home/index
   # GET /home/index.json
   def index
      @selected_projects = Project.selected_projects(12)
   end
end
