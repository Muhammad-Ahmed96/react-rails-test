
class ProjectsController < ApplicationController
  before_action :check_login
  before_action :find_project, except: [ :index ]

  def index
    @projects = current_user.projects
    render json: @projects, each_serializer: ProjectSerializer
  end
  def show
    render json: @project, serializer: ProjectSerializer
  end


  private
  def find_project
    begin
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Project not found" }, status: :not_found and return
    end
  end

  def find_task
    begin
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Task not found" }, status: :not_found and return
    end
  end
end
