# frozen_string_literal: true

class MetalMineUpgrade < ApplicationRecord
  BASE_COST = 60
  CUMULATIVE_FACTOR = 4.5
  TIME_FACTOR = 7.0

  belongs_to :planet

  validates :target_level, presence: true, numericality: {only_integer: true}
  validates :ends_at, presence: true

  scope :in_progress, -> { where(finished: false) }

  def self.cost_for_level(level)
    (BASE_COST * CUMULATIVE_FACTOR**(level - 1)).floor
  end

  def self.duration_for_level(level)
    (cost_for_level(level) / TIME_FACTOR).round.seconds
  end
end
