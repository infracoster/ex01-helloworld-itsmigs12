
module Utils
  def formatted_time(time_value)
    format = "%F %T %z"
    if time_value.is_a?(DateTime) || time_value.is_a?(Time)
      time_value
    else
      DateTime.strptime(time_value, '%s')
    end.strftime(format)
  end

  def format_output(obj)
    if obj.is_a?(String)
      obj
    elsif obj.is_a?(Array)
      obj.join(',')
    else
      raise ArgumentError
    end