# frozen_string_literal: true

class UpdatePlanetResourcesJob
  include Sidekiq::Job

  def perform(planet_id)
    Planet.find(planet_id).update_resources!
  end
end
