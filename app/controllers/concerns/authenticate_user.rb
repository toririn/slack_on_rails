module AuthenticateUser
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  private

  def authenticate_user!
    return redirect_to root_path, notice: "ログインしてないですよ〜。ログインしてください！" if session[:user].blank?
    if verify_session?
      session[:user]["ts"] = Time.zone.now.to_i
    else
      session[:user] = nil
      redirect_to root_path, notice: "ログイン情報が不正か、前回のログインがかなり昔のようです。もう一度認証をお願いします。"
    end
  end

  def verify_session?
    if session[:user].present?
      verify_token? && verify_date?
    else
      false
    end
  end

  def verify_token?
    session[:user]["token"] == SLACK_ON_RAILS_TOKEN
  end

  def verify_date?
    session[:user]["ts"] > Time.zone.now.days_ago(Sessions::HOLDING_PERIOD).to_i
  end
end
