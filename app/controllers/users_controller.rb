# frozen_string_literal: true

class UsersController < Clearance::UsersController
  def create
    @user = user_from_params

    signed_up = ActiveRecord::Base.transaction do
      @user.save && @user.planets.create
    end

    if signed_up
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new", status: :unprocessable_entity
    end
  end
end
