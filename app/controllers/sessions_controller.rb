require 'slack'
class SessionsController < ApplicationController
  include AuthenticateUser
  skip_before_action :authenticate_user!
  after_action :update_last_auth, only: [:create_session, :restore_session]
  def index
    redirect_to top_path if verify_session?
  end

  def login
    if authenticated_user?
      restore_session
      redirect_to controller: 'together', action: 'top'
    else
      redirect_to "/#{Constants::ROOT_PATH}auth/slack"
    end
  end

  def create
    slack_data = request.env['omniauth.auth']
    if create_session(slack_data)
      redirect_to controller: 'together', action: 'top'
    else
      flash[:notice] = "Slackから拒否されちゃいました。また後でやってみてください。"
      redirect_to action: 'index'
    end
  end

  def destroy
    session[:user] = nil
    flash[:notice] = "ログアウトが完了しました。さようなら！"
    redirect_to action: 'index'
  end

  private

  def create_session(slack_data)
    return false if slack_data.blank?
    reset_session
    session[:user] = {}
    session[:user]["name"] = slack_data["info"]["user"]
    session[:user]["id"] = slack_data["info"]["user_id"]
    session[:user]["token"] = Constants::SLACK_ON_RAILS_TOKEN
    session[:user]["ts"] = Time.zone.now.to_i
    session[:token] = slack_data["credentials"]["token"]
  rescue => ex
    return false
  end

  def authenticated_user?
    return false if session[:token].blank?
    Slack.configure { |config| config.token = session[:token] }
    @auth_data = Slack.client.auth_test
    return false if verify_last_auth
    @auth_data["ok"]
  rescue => ex
    return false
  end

  def restore_session
    session[:user] = {}
    session[:user]["name"] = @auth_data["user"]
    session[:user]["id"] = @auth_data["user_id"]
    session[:user]["token"] = Constants::SLACK_ON_RAILS_TOKEN
    session[:user]["ts"] = Time.zone.now.to_i
  end

  def update_last_auth
    User.find(session[:user]["id"]).update(last_auth: Time.zone.today)
  end

  def verify_last_auth
    User.find(@auth_data[:user_id]).update < Time.zone.today - 10 rescue false
  end
end
