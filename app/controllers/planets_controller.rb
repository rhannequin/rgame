# frozen_string_literal: true

class PlanetsController < ApplicationController
  before_action :require_login

  def show
    @planet = Planet.find(params[:id])
    UpdatePlanetResourcesJob.perform_sync(@planet.id)
    @planet.reload
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
