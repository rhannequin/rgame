# frozen_string_literal: true

class Planet < ApplicationRecord
  belongs_to :user

  has_many :pending_metal_mine_upgrades,
    -> { where(finished: false) },
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

  private

  def time_since_last_resources_update
    (Time.current - resources_updated_at).floor
  end

  def metal_production_per_second
    metal_basic_income * metal_mine_level
  end
end
