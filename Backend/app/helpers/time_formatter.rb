module TimeFormatter
  def format_time(seconds)
    seconds = seconds.to_i
    minutes = seconds / 60
    hours = minutes / 60
    days = hours / 24
    weeks = days / 7
    months = days / 30
    years = days / 365

    if years > 0
      "#{years} year#{'s' if years > 1}"
    elsif months > 0
      "#{months} month#{'s' if months > 1}"
    elsif weeks > 0
      "#{weeks} week#{'s' if weeks > 1}"
    elsif days > 0
      "#{days} day#{'s' if days > 1}"
    elsif hours > 0
      "#{hours} hour#{'s' if hours > 1}"
    elsif minutes > 0
      "#{minutes} minute#{'s' if minutes > 1}"
    else
      "less than a minute"
    end
  end
end
