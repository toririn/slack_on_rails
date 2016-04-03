class Channel < ActiveRecord::Base
  validates :id,   presence: true
  validates :name, presence: true

  scope :otack_channels, -> { ransack(name_start: "wotax_").result }

  def self.convert(id: nil, name: nil)
    @@channels ||= Channel.pluck(:id, :name)
    if id
      @@channels.find{|channel_id, channel_name| channel_id == id }.try(:[], 1)
    elsif name
      @@channels.find{|channel_id, channel_name| channel_name == name }.try(:[], 0)
    else
      "not found"
    end
  end
end
