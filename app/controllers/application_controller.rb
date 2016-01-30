class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def authenticate_user!
    return redirect_to root_path if session[:user].blank?
    if session[:user]["token"] == SLACK_ON_RAILS_TOKEN && session[:user]["ts"] > Time.zone.yesterday.to_time.to_i
      session[:user]["ts"] = Time.zone.now.to_i
    else
      reset_session
      redirect_to root_path
    end
  end
end
