class AuthenticationsController < ApplicationController
  def create
    #render json: user_hash.to_json
    authentication = Authentication.find_or_create_with_hash(user_hash)
    if authentication.user
      #login user
      login(authentication.user)
      redirect_to root_path, notice: "Logged in."
    else
      if current_user
        #already logged in, connecting authentication to current_user
        current_user.authentications << authentication
        redirect_to root_path, notice: 'Successfully added connection.'
      else
        #need to create a new user and connecct to authentication, login new user
        user = create_user(authentication)
        login(user)
        redirect_to root_path, notice: 'Created account.'
      end
    end
  end
  
  private
  
  def user_hash
    request.env['omniauth.auth']
  end
  
  def create_user(authentication)
    user = User.new
    user.apply_hash(user_hash)
    user.save!
    user.authentications << authentication
    user
  end
end
