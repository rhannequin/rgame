# frozen_string_literal: true

require "rails_helper"

describe "the authentication process", type: :feature do
  describe "Signing up" do
    scenario "with valid email and password" do
      visit root_path
      click_link "Sign in"
      click_link "Sign up"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      click_button "Sign up"

      expect(page).to have_content "Signed in as: test@example.com"
    end

    scenario "with an already used email address" do
      create(:user, email: "test@example.com")

      visit root_path
      click_link "Sign in"
      click_link "Sign up"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      click_button "Sign up"

      expect(page).to_not have_content "Signed in as: test@example.com"
    end
  end

  describe "Signing in" do
    scenario "with correct credentials" do
      create(:user, email: "test@example.com", password: "password")

      visit root_path
      click_link "Sign in"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      click_button "Sign in"

      expect(page).to have_content "Signed in as: test@example.com"
    end

    scenario "with incorrect credentials" do
      create(:user, email: "test@example.com", password: "password")

      visit root_path
      click_link "Sign in"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "invalid-password"
      click_button "Sign in"

      expect(page).to_not have_content "Signed in as: test@example.com"
    end
  end

  describe "Signing out" do
    scenario "it signs out the user" do
      create(:user, email: "test@example.com", password: "password")

      visit root_path
      click_link "Sign in"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      click_button "Sign in"
      click_button "Sign out"

      expect(page).to have_link "Sign in"
    end
  end
end
