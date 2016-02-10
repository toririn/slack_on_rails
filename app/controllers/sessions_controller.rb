class SessionsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    redirect_to top_path if session[:user].try(:[], "token") == SLACK_ON_RAILS_TOKEN
  end

  def create
    slack_data = request.env['omniauth.auth']
    if create_session(slack_data)
      redirect_to top_path
    else
      redirect_to root_path, notice: "Slackから拒否されちゃいました。また後でやってみてください。"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトが完了しました。さようなら！"
  end

  private

  def create_session(slack_data)
    return false if slack_data.blank?
    reset_session
    session[:user] = {}
    session[:user]["name"] = slack_data["info"]["user"]
    session[:user]["id"] = slack_data["info"]["user_id"]
    session[:user]["token"] = SLACK_ON_RAILS_TOKEN
    session[:user]["ts"] = Time.zone.now.to_i
  rescue => ex
    return false
  end

end
