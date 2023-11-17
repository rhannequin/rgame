# frozen_string_literal: true

require "rails_helper"

describe Planet do
  describe "factory" do
    it "allows to create a records" do
      expect { create(:planet) }.not_to raise_error
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:pending_metal_mine_upgrades) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:metal_mine_level) }
    it { is_expected.to validate_numericality_of(:metal_mine_level).only_integer }
    it { is_expected.to validate_presence_of(:metal_basic_income) }
    it { is_expected.to validate_numericality_of(:metal_basic_income).only_integer }
  end

  describe "#update_resources!" do
    it "updates metal based on time since last update" do
      planet = create(
        :planet,
        metal: 0,
        metal_basic_income: 10,
        metal_mine_level: 2,
        resources_updated_at: 1.hour.ago
      )
      planet.update_resources!
      expect(planet.reload.metal).to eq(72000)
    end
  end

  describe "#metal_production_hourly_rate" do
    it "returns the hourly metal production rate" do
      planet = create(:planet, metal_basic_income: 10, metal_mine_level: 2)

      expect(planet.metal_production_hourly_rate).to eq(72000)
    end
  end

  describe "#next_metal_mine_level" do
    it "returns the next metal mine level" do
      planet = create(:planet, metal_mine_level: 2)

      expect(planet.next_metal_mine_level).to eq(3)
    end
  end
end
