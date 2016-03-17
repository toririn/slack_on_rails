class OtacksController < SlackAppController

  before_action :set_user_image_list, only: [:search, :search_link]

  def index
    @otacks = Otack.all
  end

  def show
  end

  def search
  end

  private

end
