

class TaskSerializer < ActiveModel::Serializer
  include TimeFormatter
  attributes :name, :duration, :start_end


  def start_end
    "#{object.start_time.strftime('%-l:%M %p')} - #{object.end_time.strftime('%-l:%M %p')}, #{object.start_time.strftime('%b %-d')}"
  end

  def duration
    format_time(object.duration)
  end
end
