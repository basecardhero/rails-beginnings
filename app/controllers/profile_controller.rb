class ProfileController < ApplicationController
  before_action :require_email_confirmation, only: [ :update, :update_email ]

  def index
  end

  def update
    if current_user.update(update_profile_params)
      redirect_to profile_path, notice: "Profile updated"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update_email
    if current_user.update(update_email_params)
      redirect_to profile_path, notice: "Email address updated"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update_password
    unless current_user.authenticate(params[:user][:current_password])
      current_user.errors.add(:current_password, "is incorrect")
      return render :index, status: :unprocessable_entity
    end

    unless current_user.update(update_password_params)
      return render :index, status: :unprocessable_entity
    end

    PasswordsMailer.changed(current_user).deliver_later

    redirect_to profile_path, notice: "Password updated"
  end

  private

  def update_profile_params
    params.expect(user: [ :username ])
      .with_defaults(username: "")
  end

  def update_email_params
    params.expect(user: [ :email_address ])
      .with_defaults(email_address: "")
  end

  def update_password_params
    params.expect(user: [ :password, :password_confirmation ])
      .with_defaults(password: "", password_confirmation: "")
  end
end
