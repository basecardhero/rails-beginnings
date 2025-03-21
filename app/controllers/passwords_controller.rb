class PasswordsController < ApplicationController
  layout "authentication"
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]
  rate_limit to: 10, within: 3.minutes, only: [ :create, :update ], with: -> { redirect_to new_password_path, alert: "Try again later." }

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
  end

  def edit
  end

  def update
    if @user.update(update_password_params.merge(confirmed_at: Time.current))
      @user.sessions.destroy_all
      return redirect_to new_session_path, notice: "Your password has been reset. You may now log in."
    end

    render :edit, status: :unprocessable_entity
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
    end

    def update_password_params
      params.require(:user).permit(:password, :password_confirmation)
        .with_defaults(password_confirmation: "")
    end
end
