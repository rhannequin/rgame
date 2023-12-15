# frozen_string_literal: true

class Planet < ApplicationRecord
  belongs_to :user

  has_many :metal_mine_upgrades, dependent: :destroy, inverse_of: :planet
  has_many :pending_metal_mine_upgrades,
    -> { in_progress },
    class_name: "MetalMineUpgrade",
    dependent: :destroy,
    inverse_of: :planet

  validates :metal_mine_level, presence: true, numericality: {only_integer: true}
  validates :metal_basic_income, presence: true, numericality: {only_integer: true}

  def update_resources!
    if time_since_last_resources_update >= 1
      self.metal += time_since_last_resources_update * metal_production_per_second
      self.resources_updated_at = Time.current
      save!
    end
  end

  def metal_production_per_second
    metal_basic_income * metal_mine_level
  end

  def metal_production_hourly_rate
    metal_production_per_second * 1.hour.to_i
  end

  def next_metal_mine_level
    metal_mine_level + 1
  end

  private

  def time_since_last_resources_update
    (Time.current - resources_updated_at).floor
  end
end
