# frozen_string_literal: true

require "rails_helper"

describe "POST /users" do
  context "when user is signed out" do
    context "with valid attributes" do
      it "redirects to the redirect_url" do
        user_attributes = attributes_for(:user)
        old_user_count = User.count

        post users_path, params: {
          user: user_attributes
        }

        expect(User.count).to eq old_user_count + 1
        expect(response).to redirect_to(Clearance.configuration.redirect_url)
      end

      it "creates a planet for the user" do
        user_attributes = attributes_for(:user)

        post users_path, params: {user: user_attributes}

        user = User.find_by(email: user_attributes[:email])
        expect(user.planets.count).to be 1
      end
    end

    context "with invalid attributes" do
      it "renders the page with error" do
        user_attributes = attributes_for(:user, email: nil)
        old_user_count = User.count

        post users_path, params: {
          user: user_attributes
        }

        expect(User.count).to eq old_user_count
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "when user is already signed in" do
    it "redirects to the configured clearance redirect url" do
      user = create(:user)
      post(
        session_path,
        params: {session: {email: user.email, password: user.password}}
      )

      post users_path, params: {
        user: {email: user.email, password: user.password}
      }

      expect(response).to redirect_to(Clearance.configuration.redirect_url)
    end
  end
end
