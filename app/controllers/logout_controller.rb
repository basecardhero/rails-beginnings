class LogoutController < ApplicationController
  def delete
    logout
    redirect_to root_path
  end
end
