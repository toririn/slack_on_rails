class Validators::TodoWork < Validators::Base
  attr_accessor(
    :channel,
    :selected_day,
  )

  validates :channel, presence: true

end
