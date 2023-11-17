# frozen_string_literal: true

require "rails_helper"

describe "GET /planets/:id" do
  context "when user is signed in" do
    it "is successful" do
      user = create(:user)
      planet = create(:planet, user: user)

      get planet_path(planet, as: user)

      expect(response).to be_successful
    end

    context "when the planet is not found" do
      it "redirects to the root page" do
        user = create(:user)

        get planet_path(0, as: user)

        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when user is signed out" do
    it "redirects to the sign in page" do
      user = create(:user)
      planet = create(:planet, user: user)

      get planet_path(planet)

      expect(response).to redirect_to(sign_in_path)
    end
  end
end
