# config/initializers/datetime_local.rb
class Time
  DATETIME_LOCAL_FORMAT = '%Y-%m-%dT%H:%M'.freeze
  def datetime_local
    strftime(DATETIME_LOCAL_FORMAT)
  end
end

class DateTime
  DATETIME_LOCAL_FORMAT = '%Y-%m-%dT%H:%M'.freeze
  def datetime_local
    strftime(DATETIME_LOCAL_FORMAT)
  end
end
