class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  Fluent::Logger::FluentLogger.open(nil, host: "localhost", port: 24224)
  before_action :fluent_post if Rails.env.production?
  include ErrorHandlers if Rails.env.production?
  include AuthenticateUser

  def fluent_post
    Fluent::Logger.post("slack_on_rails.access", {
      "url" => request.fullpath,
      "time" => Time.zone.now.to_s,
      "user" => session[:user].try(:[], "name")
    })
  end

end
