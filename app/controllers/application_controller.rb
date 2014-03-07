class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  hide_action :current_user

  def current_user?(user)
      current_user == user
  end

  helper_method :current_user?
  hide_action :current_user?

  def require_user
    if current_user.nil?
      session[:redirect_url] = request.path
      redirect_to signin_path, notice: "Please sign in!"
    end
  end

  def authorize_user
    user = User.find(params[:id])
    unless current_user?(user)
      redirect_to root_path, notice: "Tampering another user details not allowed"
    end
  end
end
