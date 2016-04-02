class Togethers::SetedChannelSearchsController < Togethers::QuerySearchsController

  def show
    set_user_list
    set_channel_list
    @channel = params[:channel]
  end

end
