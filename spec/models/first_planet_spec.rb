# frozen_string_literal: true

require "rails_helper"

describe FirstPlanet do
  describe "#save" do
    it "creates a planet for user" do
      user = create(:user)

      expect { described_class.new(user).save }.to(
        change(user.planets, :count).by(1)
      )
    end

    it "sets metal mine level to 1" do
      user = create(:user)

      described_class.new(user).save

      expect(user.planets.first.metal_mine_level).to eq(1)
    end

    it "sets metal basic income to a random value" do
      user = create(:user)

      described_class.new(user).save

      expect(user.planets.first.metal_basic_income).to(
        be_in(FirstPlanet::METAL_BASIC_INCOME_RANGE)
      )
    end
  end
end
