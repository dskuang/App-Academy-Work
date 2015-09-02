class SessionsController < ApplicationController

  before_action :single_log_in, except: [:destroy]

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login(@user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end

  end

  def new
    #@user = current_user
    render :new

  end

  def destroy
    current_user.reset_session_token!
    logout
    redirect_to new_session_url
  end

  def single_log_in
    #fail
    if session[:session_token]
      redirect_to cats_url
    end
  end
end
