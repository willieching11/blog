class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.where(email: params[:email]).first
    if @user && @user.authenticate(params[:password])
      login(@user, params[:remember] == '1')
      redirect_path = session[:protected_page] || root_path
      session[:protected_page] = nil
      redirect_to redirect_path, notice: "Successfully logged in."
    else
      #didn't find user or incorrect password
      redirect_to login_path, alert: "Incorrect email/password."
    end
  end
  
  def destroy
    logout
    redirect_to root_path, notice: "You are logged out."
  end
end
