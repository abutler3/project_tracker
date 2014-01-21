class ProjectsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # Run before all actions in controller
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash[:alert] = "Project has not been created."
      render "new"
    end
  end

  def edit
    # @project = Project.find(params[:id])
    # Not needed because of set_project
  end

  def show
   # @project = Project.find(params[:id])
   # Not needed because of set_project
  end

  def update
    # @project = Project.find(params[:id])
    # Not needed because of set_project
    if @project.update(project_params)
    # update thats the hash of attributes, updates
    # them and saves if valid. Can return true or false

      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render "edit"
    end
  end

  def destroy
    # @project = Project.find(params[:id])
    # Not needed because of set_project
    @project.destroy

    flash[:notice] = "Project has been destroyed."
    redirect_to projects_path
  end

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end

  private
    def set_project
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to projects_path
    end

    def require_signin!
      if current_user.nil?
        flash[:error] = "You need to sign in or sign up before continuing."
        redirect_to signin_url
      end
    end
   def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end

    def authorize_admin!
      require_signin!
      # Uses method from tickets_controller to ensure the
      # user is signed in

      unless current_user.admin?
        flash[:alert] = "You must be an admin to do that."
        redirect_to root_path
        # If user is signed in and not an admin, they get the
        # message and redirect to root_path
      end
    end


end
