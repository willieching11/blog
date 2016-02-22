class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authorize
    if current_user.nil?
      session[:protected_page] = request.fullpath
      redirect_to login_path, alert: "You need to login to view that page."
    end
  end

  def login(user, remember = false)
    if remember
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
  end
  
  def logout
    cookies.delete(:auth_token)
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user
  
  def set_article
    @article = current_user.articles.find_by(params[:article_id])
  end
end
