# frozen_string_literal: true

module TimeHelper
  def duration_in_words(duration)
    ActiveSupport::Duration.build(duration).inspect
  end
end
