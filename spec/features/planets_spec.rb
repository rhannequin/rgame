# frozen_string_literal: true

require "rails_helper"

describe "Planets" do
  describe "planet's resources" do
    it "shows updated values" do
      travel_to Time.zone.local(2023, 10, 22, 12, 0, 0) do
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
      end

      travel_to Time.zone.local(2023, 10, 22, 13, 0, 0) do
        visit root_path
        click_link I18n.t("planets.homeworld")

        expect(page).to have_content("72,000")
      end
    end
  end

  describe "planet's metal mine upgrades" do
    it "enables the user to upgrade the metal mine level" do
      travel_to Time.zone.local(2023, 10, 22, 12, 30, 0) do
        user = create(:user, password: "password")
        create(:planet, user: user, metal_mine_level: 1, metal: 10_000)
        sign_in_with(user.email, "password")

        visit root_path
        click_link I18n.t("planets.homeworld")

        expect(page).to have_content("Upgrade")
        expect(page).to have_content("270 Metal")
        expect(page).to have_content("39 seconds")

        click_link "Upgrade"

        expect(page).to have_content("9,730")
        expect(page).to have_content("Upgrade to level 2 finished in 39 seconds")
      end
    end
  end
end
