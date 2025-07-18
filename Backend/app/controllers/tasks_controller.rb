
class TasksController < ApplicationController
  before_action :find_task, only: [ :remove ]
  before_action :find_project

  def add
    begin
      render json: { error: "Project Not Active Yet, Can't Add Task" }, status: :unprocessable_entity and return unless @project.active?
      task = Task.new(task_params.merge(project_id: @project.id))
      task.duration = "#{task.duration} #{task.duration_type}".split.then { |dur, unit| dur.to_i.send(unit).to_i }
      if task.save
        render json: task, serializer: TaskSerializer, status: :ok
      else
        render json: { error: "Something went wrong" }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { error: e }, status: :unprocessable_entity
    end
  end

  def remove
    begin
      @project.tasks.delete(@task)
      render json: { msg: "Task Removed Successfully" }, status: :ok
    rescue StandardError => e
      render json: { error: e }, status: :unprocessable_entity
    end
  end

  private
    def find_project
      begin
        @project = Project.find(params[:project_id])
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

    def task_params
      params.expect(task: [ :name, :description, :start_time, :end_time, :duration, :duration_type ])
    end
end
