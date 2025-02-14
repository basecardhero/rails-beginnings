class RegistrationsController < ApplicationController
  layout "authentication"
  allow_unauthenticated_access only: %i[ new create confirm ]
  rate_limit to: 10, within: 3.minutes, only: [ :create, :confirm ], with: -> { redirect_to new_registration_path, alert: "Try again later." }

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      UserMailer.confirm_email(@user).deliver_later

      return redirect_to new_session_url, notice: "You have successfully registered! Please check your email to confirm your email address."
    end

    render :new, status: :unprocessable_entity
  end

  def confirm
    user = User.find_by_token_for(:email_confirmation, params[:token])
    if user.nil?
      return redirect_to new_session_url, alert: "The confirmation link is invalid or expired."
    end

    user.update! confirmed_at: Time.current
    redirect_to new_session_url, notice: "Your email has been confirmed. You may now log in."
  end

  private

  def create_user_params
    params.expect(user: [ :email_address, :username, :password, :password_confirmation ])
      .with_defaults(password_confirmation: "")
  end
end
