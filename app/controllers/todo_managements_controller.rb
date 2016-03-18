class TodoManagementsController < SlackAppController
  include TodoManagementsParameter

  def index
    @channel_name = params[:channel]
    @validate = Validators::TodoWork.new(params.permit(:channel))
    return render if @validate.has_error?
    set_todo_management_list_param
  end

  def modify
    @channel_name = params[:channel]
    set_todo_management_list_param
    render action: :index
  end

  def complete_task
    @channel_name = params[:channel]
    channel_id = Channel.convert(name: @channel_name)
    @result_update = slack.update_by_chat_in_channel(text: "#{Constants::TodoManagements::Keywords::DONE}::#{params[:text]}", ts: params[:ts], channel_id: channel_id)
    @result_post = slack.post_by_chat_in_channel(text: "#{Constants::TodoManagements::Keywords::DONE}::#{params[:text]}", username: session[:user]["name"], channel_id: channel_id) if @result_update
    set_todo_management_list_param
  end
end
