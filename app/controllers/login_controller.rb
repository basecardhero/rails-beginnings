class LoginController < ApplicationController
  before_action :create_user_object

  def new; end

  def create
    user = User.authenticate_by(email: login_params[:email], password: login_params[:password])
    if user
      login user
      redirect_to root_path
    else
      flash[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  private
    def login_params
      params.require(:user).permit(:email, :password)
    end

    def create_user_object
      @user = User.new
    end
end
