class LoginController < ApplicationController
  def new
    @login_form = LoginForm.new
  end

  def create
    @login_form = LoginForm.new(login_params)
    if @login_form.invalid?
      return render :new, status: :unprocessable_entity
    end

    user = User.authenticate_by(email: login_params[:email], password: login_params[:password])
    unless user
      flash[:alert] = "Invalid email or password"
      return render :new, status: :unprocessable_entity
    end

    login user
    redirect_to root_path
  end

  private
    def login_params
      params.require(:login_form).permit(:email, :password)
    end
end
