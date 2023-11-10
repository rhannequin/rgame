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
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:metal_mine_level) }
    it { is_expected.to validate_numericality_of(:metal_mine_level).only_integer }
  end

  describe "#update_resources!" do
    it "updates metal based on time since last update" do
      planet = create(:planet, metal: 0, resources_updated_at: 1.hour.ago)
      planet.update_resources!
      expect(planet.reload.metal).to eq(3600)
    end
  end
end
