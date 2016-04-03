class UserImage < ActiveRecord::Base
  validates :id,   presence: true
  validates :path, presence: true

  def self.eager_find_path(id)
    @@user_images ||= UserImage.pluck(:id, :path)
    @@user_images.find{|user_id, path| user_id == id }.try(:[], 1)
  end
end
