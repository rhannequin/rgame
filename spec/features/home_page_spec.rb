# frozen_string_literal: true

require "rails_helper"

describe "the home page" do
  describe "planet's resources" do
    it "shows updated values" do
      travel_to Time.zone.local(2023, 10, 22, 12, 0, 0) do
        user = create(:user, password: "password")
        create(
          :planet,
          user: user,
          metal: 0,
          resources_updated_at: Time.current
        )

        sign_in_with(user.email, "password")
      end

      travel_to Time.zone.local(2023, 10, 22, 13, 0, 0) do
        visit root_path

        expect(page).to have_content(3600)
      end
    end
  end
end
