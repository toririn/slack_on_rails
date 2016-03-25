module SessionsCallback
  extend ActiveSupport::Concern

  included do
    skip_before_action :authenticate_user!
    after_action :update_last_auth, only: [:create_session, :restore_session]
  end

  def update_last_auth
    User.find(session[:user][:id]).update(last_auth: Time.zone.today)
  end
end
