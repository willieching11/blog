class UsersController < ApplicationController
  before_action :authorize, except: [:new, :create]
  before_action :set_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      login @user
      redirect_to root_path, notice: "You successfully signed up!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
      if @user.update_attributes(user_params)
        redirect_to @user, notice: "Successfully saved Profile."
      else
        render :edit
      end
    end
  
  def destroy
      @user.destroy
      logout
      redirect_to root_path, notice: "Deleted Profile."
    end

  private
  def set_user
      @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
