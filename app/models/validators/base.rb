class Validators::Base
  include ActiveModel::Model

  def has_error?
    !valid?
  end

end
