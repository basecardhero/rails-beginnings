class RegistrationsController < ApplicationController
  layout "authentication"
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      return redirect_to new_session_url, notice: "Your account was successfully created! You may now log in."
    end

    render :new, status: :unprocessable_entity
  end

  private

  def create_user_params
    params.expect(user: [ :email_address, :password, :password_confirmation ])
      .with_defaults(password_confirmation: "")
  end
end
