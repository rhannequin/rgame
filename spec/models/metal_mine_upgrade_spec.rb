# frozen_string_literal: true

require "rails_helper"

describe MetalMineUpgrade do
  describe "factory" do
    it "allows to create a records" do
      expect { create(:metal_mine_upgrade) }.not_to raise_error
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:planet) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:target_level) }
    it { is_expected.to validate_numericality_of(:target_level).only_integer }
    it { is_expected.to validate_presence_of(:ends_at) }
  end

  describe "::cost_for_level" do
    [
      {level: 2, cost: 270},
      {level: 3, cost: 1_215},
      {level: 4, cost: 5_467},
      {level: 5, cost: 24_603},
      {level: 6, cost: 110_716}
    ].each do |test_case|
      it "returns the right cost for the level #{test_case[:level]}" do
        cost = described_class.cost_for_level(test_case[:level])
        expect(cost).to eq(test_case[:cost])
      end
    end
  end

  describe "::duration_for_level" do
    [
      {level: 2, duration: 39.seconds},
      {level: 3, duration: 174.seconds},
      {level: 4, duration: 781.seconds},
      {level: 5, duration: 3_515.seconds},
      {level: 6, duration: 15_817.seconds}
    ].each do |test_case|
      it "returns the right duration for the level #{test_case[:level]}" do
        duration = described_class.duration_for_level(test_case[:level])
        expect(duration).to eq(test_case[:duration])
      end
    end
  end

  describe "#time_remaining" do
    it "returns the time remaining until the upgrade is finished" do
      travel_to Time.zone.local(2023, 10, 22, 12, 0, 0) do
        upgrade = create(:metal_mine_upgrade, ends_at: 1.hour.from_now)

        expect(upgrade.time_remaining).to eq(1.hour)
      end
    end
  end
end
