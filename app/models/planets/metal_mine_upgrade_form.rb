# frozen_string_literal: true

module Planets
  class MetalMineUpgradeForm
    include ActiveModel::Model

    attr_accessor :planet

    validate :no_pending_upgrades
    validate :sufficient_resources

    def save
      return false unless valid?

      ApplicationRecord.transaction do
        planet.update!(metal: planet.metal - cost)
        metal_mine_upgrade.save!
      end
    end

    private

    def no_pending_upgrades
      return if planet.pending_metal_mine_upgrades.empty?

      errors.add(:base, :pending_upgrade)
    end

    def sufficient_resources
      return if planet.metal >= cost

      errors.add(:base, :insufficient_resources)
    end

    def metal_mine_upgrade
      @_metal_mine_upgrade ||= planet.metal_mine_upgrades.build(
        target_level: target_metal_mine_level,
        ends_at: ends_at
      )
    end

    def current_metal_mine_level
      planet.metal_mine_level
    end

    def target_metal_mine_level
      current_metal_mine_level + 1
    end

    def ends_at
      Time.current + MetalMineUpgrade.duration_for_level(target_metal_mine_level)
    end

    def cost
      MetalMineUpgrade.cost_for_level(target_metal_mine_level)
    end
  end
end
