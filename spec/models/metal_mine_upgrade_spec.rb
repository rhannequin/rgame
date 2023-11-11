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
end
