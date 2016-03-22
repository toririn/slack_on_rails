class Session < ActiveRecord::Base
  scope :old, -> { ransack(updated_at_lteq: Time.zone.yesterday).result }
end
