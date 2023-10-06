# frozen_string_literal: true

require "rails_helper"

describe User do
  describe "factory" do
    it "allows to create a records" do
      expect { create(:user) }.not_to raise_error
    end
  end

  it { is_expected.to validate_presence_of(:email) }
end
