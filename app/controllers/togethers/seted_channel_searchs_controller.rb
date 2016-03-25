class Togethers::SetedChannelSearchsController < Togethers::QuerySearchsController

  def index
    @channel = params[:channel]
  end

end
