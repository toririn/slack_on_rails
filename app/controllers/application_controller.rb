class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  Fluent::Logger::FluentLogger.open(nil, host: "localhost", port: 24224)
  before_action :authenticate_user!
  before_action :fluent_post if Rails.env.production?
  include ErrorHandlers if Rails.env.production?

  def authenticate_user!
    return redirect_to root_path, notice: "ログインしてないですよ〜。ログインしてください！" if session[:user].blank?
    if session[:user]["token"] == SLACK_ON_RAILS_TOKEN && session[:user]["ts"] > Time.zone.now.days_ago(30).to_i
      session[:user]["ts"] = Time.zone.now.to_i
    else
      reset_session
      redirect_to root_path, notice: "ログイン情報が不正か、前回のログインがかなり昔のようです。もう一度認証をお願いします。"
    end
  end

  def fluent_post
    Fluent::Logger.post("slack_on_rails.access", {
      "url" => request.fullpath,
      "time" => Time.zone.now.to_s,
      "user" => session[:user].try(:[], "name")
    })
  end
end
