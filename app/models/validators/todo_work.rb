class Validators::TodoWork < Validators::Base
  include Service::Base::TodoWork

  validates :channel, presence: true

end
