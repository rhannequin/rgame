# frozen_string_literal: true

require "rails_helper"

describe UpdateAllPlanetsResourcesJob do
  it "enqueues a job for each planet" do
    Sidekiq::Testing.inline! do
      create_list(:planet, 2)
      allow(UpdatePlanetResourcesJob).to receive(:perform_async)

      described_class.perform_async

      expect(UpdatePlanetResourcesJob).to(
        have_received(:perform_async).exactly(2).times
      )
    end
  end
end
