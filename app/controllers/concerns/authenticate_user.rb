module AuthenticateUser
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  private

  def authenticate_user!
    if session[:user].blank?
      flash[:notice] = "ログインしてないですよ〜。ログインしてください！"
      return redirect_to root_url
    end
    if verify_session?
      session[:user][:ts] = Time.zone.now.to_i
    else
      session[:user] = nil
      flash[:notice] =  "ログイン情報が不正か、前回のログインがかなり昔のようです。もう一度認証をお願いします。"
      redirect_to root_url
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
    session[:user][:token] == Constants::SLACK_ON_RAILS_TOKEN
  end

  def verify_date?
    session[:user][:ts] > Time.zone.now.days_ago(Constants::Sessions::HOLDING_PERIOD).to_i
  end
end
