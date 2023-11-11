# frozen_string_literal: true

class MetalMineUpgrade < ApplicationRecord
  belongs_to :planet

  validates :target_level, presence: true, numericality: {only_integer: true}
  validates :ends_at, presence: true
end
