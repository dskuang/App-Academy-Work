class ApplicationController < ActionController::Base
  helper_method :current_user

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def login(user)
   session[:session_token] = user.reset_session_token!
  end

  def logout
    session[:session_token] = nil
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception

end
