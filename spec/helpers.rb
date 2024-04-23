module Helpers
  def sign_in_as(user)
    post login_path, params: { user: { email: user.email, password: user.password } }
  end
end
