class Validators::SlackSearch < Validators::Base
  include Service::Base::Slack

  validates :channel, presence: true
  validates :user, presence: true
  validates :reaction, presence: true
  #validates :keywords
  #validates :current_user_id

end
