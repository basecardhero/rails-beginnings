class RegisterController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(register_params)
    if @user.save
      flash[:success] = "Thank you for registering. You may now log in."
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def register_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end
end
