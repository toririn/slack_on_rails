class FormValidators::ChannelValidator < BaseValidator
  attr_accessor(
    :channel,
  )

  validates :channel, presence: true

end
