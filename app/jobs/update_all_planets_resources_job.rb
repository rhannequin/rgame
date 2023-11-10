# frozen_string_literal: true

class UpdateAllPlanetsResourcesJob
  include Sidekiq::Job

  def perform
    Planet.find_each do |planet|
      UpdatePlanetResourcesJob.perform_async(planet.id)
    end
  end
end
