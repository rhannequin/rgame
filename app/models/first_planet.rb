# frozen_string_literal: true

class FirstPlanet
  METAL_BASIC_INCOME_RANGE = 240..324

  def initialize(user)
    @user = user
    @planet = @user.planets.new
  end

  def save
    init_metal_basic_income

    @planet.save
  end

  private

  def init_metal_basic_income
    @planet.metal_basic_income = METAL_BASIC_INCOME_RANGE.to_a.sample
  end
end
