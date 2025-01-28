class ProfileController < ApplicationController
  before_action :require_email_confirmation, only: :update

  def index
  end

  def update
    if current_user.update(update_profile_params)
      redirect_to profile_path, notice: "Profile updated"
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def update_profile_params
    params.expect(user: [ :username, :email_address ])
      .with_defaults(username: "", email_address: "")
  end
end
