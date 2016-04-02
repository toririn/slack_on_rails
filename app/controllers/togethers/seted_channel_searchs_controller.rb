class Togethers::SetedChannelSearchsController < Togethers::QuerySearchsController

  def index
    set_user_list
    set_channel_list
  end

  def show
    @channel = params[:channel]
  end

end
