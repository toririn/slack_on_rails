class Forms::ChannelValidator < BaseValidator
  attr_accessor(
    :channel,
  )

  validates :channel, presence: true

end
