class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    slack_data = request.env['omniauth.auth']
    return redirect_to root_url, notice: Constants::Sessions::Errors::Messages::DIFFERENT_TEAM unless verify_login_team?(slack_data["info"]["team"], slack_data["info"]["team_id"])
    if create_session(slack_data)
      redirect_to tops_url
    else
      redirect_to root_url, notice: Constants::Sessions::Errors::Messages::SLACK_AUTH_ERROR
    end
  end

  def destroy
    session[:user] = nil
    flash[:notice] = Constants::Sessions::LOGOUT_MESSAGE
    redirect_to root_url
  end

  private

  def create_session(slack_data)
    return false if slack_data.blank?
    reset_session
    session[:user] = {}.tap do |user|
      user[:name]  = slack_data["info"]["user"]
      user[:id]    = slack_data["info"]["user_id"]
      user[:token] = Constants::SLACK_ON_RAILS_TOKEN
      user[:ts]    = Time.zone.now.to_i
    end
    session[:token] = slack_data["credentials"]["token"]
    User.find(session[:user][:id]).auth_date_update
  rescue => ex
    logger.debug(ex.messages)
    logger.debug(ex.backtrace.join(String::LF))
    return false
  end

  # 認証チーム先が設定したチームのものかを確認する。
  def verify_login_team?(team, team_id)
    team == Constants::SLACK_TEAM_NAME && team_id == Constants::SLACK_TEAM_ID
  end
end
