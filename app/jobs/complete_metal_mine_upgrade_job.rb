# frozen_string_literal: true

class CompleteMetalMineUpgradeJob
  include Sidekiq::Job

  def perform(metal_mine_upgrade_id)
    metal_mine_upgrade = MetalMineUpgrade
      .in_progress
      .find(metal_mine_upgrade_id)

    ApplicationRecord.transaction do
      metal_mine_upgrade.complete!
      metal_mine_upgrade.planet.update!(
        metal_mine_level: metal_mine_upgrade.target_level
      )
      UpdatePlanetResourcesJob.perform_sync(
        metal_mine_upgrade.planet_id
      )
    end
  end
end
