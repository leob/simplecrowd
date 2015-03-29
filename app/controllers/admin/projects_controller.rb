class Admin::ProjectsController < Admin::BaseController
   before_action :set_project, only: [:show, :edit, :update]

   before_action :authenticate_user!, only: [:new, :edit, :create, :update]
   before_action :require_project_owner!, only: [:edit, :update]

   before_action :set_title

   respond_to :html

   def index
      @projects = Project.search_and_order(params[:search], params[:page])
      respond_with(:admin, @projects)
   end

   def show
      respond_with(:admin, @project)
   end

   def new
      @project = Project.new
      respond_with(:admin, @project)
   end

   def edit
   end

   def create
      @project = Project.new(project_params)
      @project.owner = current_user

      @project.save
      respond_with(:admin, @project)
   end

   def update
      @project.update(project_params)
      respond_with(:admin, @project)
   end

   private

   def require_project_owner!
      authenticate_user!

      if current_user != @project.owner
         redirect_to root_path
      end
   end

   def set_title
      page_title("forms.projects.title")
   end

   def set_project
      @project = Project.find(params[:id])
   end

   def project_params
      params.require(:project).permit(:name, :summary, :description, :image, :editor_pick,
                                      :target_amount, :target_amount_currency,
                                      :collected_amount, :collected_amount_currency)
   end
end
