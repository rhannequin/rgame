# frozen_string_literal: true

require "rails_helper"

describe FlashHelper do
  describe "#color_for_alert_type" do
    it "returns the correct color for notice" do
      expect(helper.color_for_alert_type("notice")).to(
        eq("border-green-400 text-green-700")
      )
    end

    it "returns the correct color for info" do
      expect(helper.color_for_alert_type("info")).to(
        eq("border-blue-400 text-blue-700")
      )
    end

    it "returns the correct color for warning" do
      expect(helper.color_for_alert_type("warning")).to(
        eq("border-orange-400 text-orange-700")
      )
    end

    it "returns the correct color for error" do
      expect(helper.color_for_alert_type("error")).to(
        eq("border-red-400 text-red-700")
      )
    end

    it "returns the correct color for unknown type" do
      expect(helper.color_for_alert_type("unknown")).to(
        eq("border-blue-400 text-blue-700")
      )
    end
  end
end
