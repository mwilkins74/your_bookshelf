class ApplicationController < ActionController::Base
  before_action :authorized, except: :index
  before_action :authenticate_user

  helper_method :current_user
  helper_method :user_logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    !current_user.nil?
  end

  def authorized
    redirect_to root_path unless user_logged_in?
  end

  private

  def authenticate_user
    unless user_logged_in? || sessions_controller_actions.include?(params[:action]) || request.path == root_path
      redirect_to root_path, alert: "Please log in to access this page."
    end
  end

  def sessions_controller_actions
    ['new', 'create']
  end

end
