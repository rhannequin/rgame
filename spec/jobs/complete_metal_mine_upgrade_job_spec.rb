# frozen_string_literal: true

require "rails_helper"

describe CompleteMetalMineUpgradeJob do
  it "marks an upgrade as finished" do
    Sidekiq::Testing.inline! do
      metal_mine_upgrade = create(:metal_mine_upgrade, :in_progress)

      described_class.perform_async(metal_mine_upgrade.id)

      expect(metal_mine_upgrade.reload).to be_finished
    end
  end

  it "upgrades the associated metal mine's level" do
    Sidekiq::Testing.inline! do
      planet = create(:planet, metal_mine_level: 1)
      metal_mine_upgrade = create(
        :metal_mine_upgrade,
        :in_progress,
        planet: planet,
        target_level: 2
      )

      described_class.perform_async(metal_mine_upgrade.id)

      expect(planet.reload.metal_mine_level).to eq(2)
    end
  end

  it "triggers the planet's resources update" do
    Sidekiq::Testing.inline! do
      allow(UpdatePlanetResourcesJob).to receive(:perform_sync)
      metal_mine_upgrade = create(:metal_mine_upgrade, :in_progress)

      described_class.perform_async(metal_mine_upgrade.id)

      expect(UpdatePlanetResourcesJob).to(
        have_received(:perform_sync).with(metal_mine_upgrade.planet.id)
      )
    end
  end

  context "when the completion fails" do
    it "doesn't complete and doesn't upgrade" do
      planet = create(:planet, metal_mine_level: 1)
      metal_mine_upgrade = create(
        :metal_mine_upgrade,
        :in_progress,
        planet: planet,
        target_level: 2
      )
      allow(metal_mine_upgrade).to(
        receive(:complete!).and_raise(ActiveRecord::RecordInvalid)
      )

      described_class.perform_async(metal_mine_upgrade.id)

      expect(metal_mine_upgrade.reload).not_to be_finished
      expect(planet.reload.metal_mine_level).to eq(1)
    end
  end
end
