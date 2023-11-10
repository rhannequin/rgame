# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @planets = signed_in? ? current_user.planets : Planet.none
    @planets.map(&:id).each do |planet_id|
      UpdatePlanetResourcesJob.perform_sync(planet_id)
    end
    @planets.reload
  end
end
