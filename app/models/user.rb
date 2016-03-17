class User < ActiveRecord::Base
  def self.convert(id: nil, name: nil)
    @@users ||= User.pluck(:id, :name)
    if id
      @@users.find{|user_id, user_name| user_id == id }.try(:[], 1)
    elsif name
      @@users.find{|user_id, user_name| user_name == name }.try(:[], 0)
    else
      ""
    end
  end
end
