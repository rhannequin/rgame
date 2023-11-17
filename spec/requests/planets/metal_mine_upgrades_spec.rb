# frozen_string_literal: true

require "rails_helper"

describe "POST /planets/:planet_id/metal_mine_upgrades" do
  context "when user is signed in" do
    it "redirects with a successful flash message" do
      stub_metal_mine_upgrade_form(successful: true)
      user = create(:user)
      planet = create(:planet, user: user, metal_mine_level: 1)

      post planet_metal_mine_upgrades_path(planet, as: user)

      expect(response).to redirect_to root_path
      expect(flash[:notice]).to(
        eq I18n.t("planets.metal_mine_upgrades.create.success")
      )
    end

    context "when the form is invalid" do
      it "redirects with an alert flash message" do
        stub_metal_mine_upgrade_form(
          successful: false,
          error: "Something went wrong"
        )
        user = create(:user)
        planet = create(:planet, user: user, metal_mine_level: 1)

        post planet_metal_mine_upgrades_path(planet, as: user)

        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq "Something went wrong"
      end
    end

    context "when the planet is not found" do
      it "redirects to the root page" do
        user = create(:user)

        post planet_metal_mine_upgrades_path(0, as: user)

        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when user is signed out" do
    it "redirects to the sign in page" do
      user = create(:user)
      planet = create(:planet, user: user)

      post planet_metal_mine_upgrades_path(planet)

      expect(response).to redirect_to(sign_in_path)
    end
  end

  def stub_metal_mine_upgrade_form(successful: true, error: nil)
    form = instance_double(Planets::MetalMineUpgradeForm, save: successful)
    if error.present?
      full_messages = Struct.new(:full_messages).new([error])
      allow(form).to receive(:errors).and_return(full_messages)
    end
    allow(Planets::MetalMineUpgradeForm).to receive(:new).and_return(form)
  end
end
