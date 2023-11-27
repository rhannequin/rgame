# frozen_string_literal: true

require "rails_helper"

describe FlashHelper do
  describe "#color_for_alert_type" do
    it "returns the correct color for notice" do
      expect(helper.color_for_alert_type("notice")).to eq(:green)
    end

    it "returns the correct color for info" do
      expect(helper.color_for_alert_type("info")).to eq(:blue)
    end

    it "returns the correct color for warning" do
      expect(helper.color_for_alert_type("warning")).to eq(:orange)
    end

    it "returns the correct color for error" do
      expect(helper.color_for_alert_type("error")).to eq(:red)
    end

    it "returns the correct color for unknown type" do
      expect(helper.color_for_alert_type("unknown")).to eq(:blue)
    end
  end
end
