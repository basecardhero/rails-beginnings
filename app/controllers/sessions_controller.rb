class SessionsController < ApplicationController
  layout "authentication"
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    @new_session_form = NewSessionForm.new
  end

  def create
    @new_session_form = NewSessionForm.new(new_session_params)
    unless @new_session_form.valid?
      return render :new, status: :unprocessable_entity
    end

    if user = User.authenticate_by(new_session_params)
      start_new_session_for(user, permanent: remember_me?)
      redirect_to root_url
    else
      redirect_to new_session_path, alert: "Invalid email or password."
    end
  end

  def destroy
    terminate_session
    clear_site_data
    redirect_to new_session_path
  end

  private

  def new_session_params
    params.expect(new_session_form: [ :email_address, :password ])
  end

  def remember_me?
    return false unless params[:new_session_form].key?(:remember_me)

    params[:new_session_form][:remember_me] == "1"
  end

  def clear_site_data
    response.headers["Clear-Site-Data"] = '"cache","storage"'
  end
end
