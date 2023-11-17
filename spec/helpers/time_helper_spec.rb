# frozen_string_literal: true

require "rails_helper"

describe TimeHelper do
  describe "#duration_in_words" do
    it "returns the duration in words" do
      duration = 1.hour + 1.minute + 1.second

      expect(duration_in_words(duration)).to(
        eq("1 hour, 1 minute, and 1 second")
      )
    end
  end
end
