class Channel < ActiveRecord::Base
  scope :otack_channels, -> { ransack(name_start: "wotax_").result }
end
