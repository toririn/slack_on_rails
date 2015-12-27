class Search::SlackSearchForm
  include ActiveModel::Model

  attr_accessor(
    :channe_id,
    :user_id,
    :reaction_id,
    :keywords,
    :current_user_id,
  )

  validates :channe_id, presence: true
  validates :user_id, presence: true
  validates :reaction_id, presence: true
  #validates :keywords
  #validates :current_user_id

  def search

  end

  private

  def set_params
    
  end

end
