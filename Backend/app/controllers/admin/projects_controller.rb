
class Admin::ProjectsController < ApplicationController
  before_action :check_admin?
  before_action :find_user, only: [ :assign, :unassign ]
  before_action :find_project, only: [ :assign, :unassign ]

  def index
    @projects = Project.active
    render json: @projects
  end

  def assign
    if @user.projects.include?(@project)
      render json: { error: "User already assigned this project" }, status: :unprocessable_entity and return
    end
    @user.projects << @project
    render json: @user, status: :ok
  end

  def unassign
    unless @user.projects.include?(@project)
      render json: { error: "User already unassigned from this project" }, status: :unprocessable_entity and return
    end
    @user.projects.delete(@project)
    render json: @user, status: :ok
  end

  private
  def find_user
    begin
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found and return
    end
  end
  def find_project
    begin
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Project not found" }, status: :not_found and return
    end
  end
end
