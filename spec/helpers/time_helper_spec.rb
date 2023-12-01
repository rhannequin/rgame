# frozen_string_literal: true

require "rails_helper"

describe TimeHelper do
  describe "#duration_to_human_time" do
    it "returns the duration in human readable time" do
      duration = 78_061.seconds

      expect(duration_to_human_time(duration)).to eq("21:41:01")
    end
  end
end
