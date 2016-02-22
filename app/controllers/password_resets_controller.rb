class PasswordResetsController < ApplicationController
  def new 
  end

  def create
    @user = User.find_by_email params[:email]
    if @user
      @user.send_reset_token
    end
    redirect_to root_path, notice: "Email sent with reset instructions."
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_time < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif @user.update_attributes(user_params)
      redirect_to login_path, notice: "The password has been reset."
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:password,:password_confirmation)
  end
end
