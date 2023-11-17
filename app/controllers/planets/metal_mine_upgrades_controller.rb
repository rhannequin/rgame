# frozen_string_literal: true

module Planets
  class MetalMineUpgradesController < ApplicationController
    before_action :require_login
    before_action :set_planet

    def create
      form = MetalMineUpgradeForm.new(planet: @planet)

      if form.save
        flash[:notice] = t(".success")
      else
        flash[:alert] = form.errors.full_messages.join(", ")
      end

      redirect_to @planet
    end

    private

    def set_planet
      @planet = current_user.planets.find(params[:planet_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
  end
end
