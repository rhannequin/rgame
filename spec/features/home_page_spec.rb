# frozen_string_literal: true

require "rails_helper"

describe "the home page" do
  it "shows the user's planets" do
    user = create(:user, password: "password")
    create(
      :planet,
      user: user,
      metal: 0,
      metal_basic_income: 10,
      metal_mine_level: 2,
      resources_updated_at: Time.current
    )

    sign_in_with(user.email, "password")
    visit root_path

    expect(page).to have_link I18n.t("planets.homeworld")
  end
end
