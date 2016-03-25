class Togethers::SetedChannelSearchsController < Togethers::QuerySearchsController
  before_action :set_query_select_list, only: [:show]

  def index
  end

  def show
    @channel = params[:channel]
  end

end
