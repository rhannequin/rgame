# frozen_string_literal: true

require "rails_helper"

describe User do
  describe "factory" do
    it "allows to create a records" do
      expect { create(:user) }.not_to raise_error
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:planets).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:encrypted_password) }

    it "validates uniqueness of email" do
      create(:user, email: "example@email.com")
      user2 = build(:user, email: "example@email.com")

      expect(user2).not_to be_valid
      expect(user2.errors.full_messages).to(
        include "Email has already been taken"
      )
    end
  end
end
