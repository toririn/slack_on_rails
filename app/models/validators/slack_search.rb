class Validators::SlackSearch < Validators::Base
  include Service::SlackBase

  validates :channel, presence: true
  validates :user, presence: true
  validates :reaction, presence: true
  #validates :keywords
  #validates :current_user_id

end
