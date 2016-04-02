class FormValidators::QueryValidator < BaseValidator
  attr_accessor(
    :channel,
    :user,
    :keywords,
  )

  validates :channel, presence: true
  validates :user, presence: true

end
