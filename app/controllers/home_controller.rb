class HomeController < ApplicationController

   # GET /home/index
   # GET /home/index.json
   def index
      @projects = Project.editor_picks.all
   end
end
