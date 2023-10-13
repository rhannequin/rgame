# frozen_string_literal: true

class UsersController < Clearance::UsersController
  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new", status: :unprocessable_entity
    end
  end
end
