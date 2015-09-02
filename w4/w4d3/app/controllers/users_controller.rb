class UsersController < ApplicationController

  # before_action :single_log_in

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to cats_url
    else
      render :new
    end

  end

  def show
  end

  # def single_log_in
  #   if session[:session_token]
  #     redirect_to cats_url
  #   end
  # end

  private


end
