require 'slack'
class LoginsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    if previously_authenticated_user?
      restore_session
      redirect_to tops_url
    else
      redirect_to "/#{Constants::ROOT_PATH}auth/slack"
    end
  end

  private

  def previously_authenticated_user?
    return false unless session[:token].present? || verify_last_auth?
    Slack.configure { |config| config.token = session[:token] }
    @auth_data = Slack.client.auth_test
    @auth_data["ok"]
  rescue => e
    return false
  end

  def restore_session
    session[:user] = {}.tap do |user|
      user[:name]  = @auth_data["user"]
      user[:id]    = @auth_data["user_id"]
      user[:token] = Constants::SLACK_ON_RAILS_TOKEN
      user[:ts]    = Time.zone.now.to_i
    end
    User.find(session[:user][:id]).auth_date_update
  end

  # 直近のログインの日付が閾値より前かを確認する。
  def verify_last_auth?
    User.find(@auth_data[:user_id]).last_auth.since(Constants::Sessions::HOLDING_PERIOD.day).future? rescue false
  end
end
