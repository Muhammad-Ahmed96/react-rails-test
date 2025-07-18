
class ProjectSerializer < ActiveModel::Serializer
  include TimeFormatter
  attributes :id, :name, :start_date, :duration, :tasks, :total_time, :users

  def tasks
    object.tasks.each_with_index.map do |task, index|
      TaskSerializer.new(task).as_json
    end
  end

  def users
    object.users.map do |user|
      UserSerializer.new(user)
    end
  end

  def total_time
    total_time = object.tasks.sum { |task| task.duration.to_i }
    format_time(total_time)
  end

  def duration
    format_time(object.duration)
  end
end
