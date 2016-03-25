class Togethers::SearchsController < SlackAppController
  before_action :set_user_image_list, only: [:search]

  include Togethers::Outputs

  private

  def set_user_image_list
    @user_image_list = slack.user_image_list
  end
end
