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
end
