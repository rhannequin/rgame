# frozen_string_literal: true

module TimeHelper
  def duration_to_human_time(duration)
    Time.at(duration).utc.strftime("%H:%M:%S")
  end
end
