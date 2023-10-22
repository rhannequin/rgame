# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @planets = signed_in? ? current_user.planets : []
    @planets.each(&:update_resources!)
  end
end
