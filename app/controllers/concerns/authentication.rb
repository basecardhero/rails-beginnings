module Authentication
  extend ActiveSupport::Concern

  included do
    def user_signed_in?
      current_user.present?
    end
    helper_method :user_signed_in?

    def current_user
      Current.user ||= get_user_from_session
    end
    helper_method :current_user

    def get_user_from_session
      User.find_by(id: session[:user_id])
    end

    def login(user)
      Current.user = user
      reset_session
      session[:user_id] = user.id
    end

    def logout
      Current.user = nil
      reset_session
    end
  end

  class_methods do
  end
end
