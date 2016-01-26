class Validators::SlackSearchLink < Validators::Base
  include Service::Base::SlackLink

  validates :link, presence: true, format: URI::regexp(%w(http https))

end
