class ProjectsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :require_signin!, only: [:index, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # Run before all actions in controller
  def index
    @projects = Project.for(current_user)
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
      @project = Project.for(current_user).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to projects_path
    end


end
