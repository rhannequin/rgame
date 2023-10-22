# frozen_string_literal: true

class Planet < ApplicationRecord
  METAL_PRODUCTION_RATIO_PER_SECOND = 1

  belongs_to :user

  def update_resources!
    time_since_last_resources_update = (Time.current - resources_updated_at).floor
    if time_since_last_resources_update >= 1
      self.metal += time_since_last_resources_update * METAL_PRODUCTION_RATIO_PER_SECOND
      self.resources_updated_at = Time.current
      save!
    end
  end
end
