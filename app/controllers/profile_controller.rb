class ProfileController < ApplicationController
  before_action :require_email_confirmation, only: [ :update, :update_email ]
  rate_limit to: 5, within: 3.minutes, only: [ :update_email, :send_email_confirmation, :update_password ],
             with: -> { redirect_to profile_url, alert: "Try again later." }

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
      if current_user.email_address_previously_changed?
        current_user.update_column(:confirmed_at, nil)
        UserMailer.confirm_email(current_user).deliver_later

        redirect_to profile_path, notice: "Email address updated"
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  def send_email_confirmation
    if current_user.confirmed_at?
      return redirect_to profile_path, alert: "Email address already confirmed."
    end

    UserMailer.confirm_email(current_user).deliver_later

    redirect_to profile_path, notice: "Confirmation email sent. Please check your email."
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
