class Forms::LinkValidator < BaseValidator
  attr_accessor(
    :link,
  )

  validates :link, presence: true, format: URI::regexp(%w(http https))
end
