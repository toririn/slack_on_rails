class TodoWorkController < SlackAppController

  def index
    @channel_name = params[:channel]
    @validate = Validators::TodoWork.new(params.permit(:channel))
    return render if @validate.has_error?

    @todo_list = todo_works.todo_list
    @do_list = todo_works.do_list
    @done_list = todo_works.done_list
    @comment_list = todo_works.comment_list
    set_todolist
  end

  def modify
    @channel_name = params[:channel]

    @todo_list = todo_works.todo_list
    @do_list = todo_works.do_list
    @done_list = todo_works.done_list
    @comment_list = todo_works.comment_list
    set_todolist
    render action: 'index'
  end

  def delete_todolist
    channel_id = Service::SlackRails.channel_name_to_id(name: params[:channel])
    @result_delete = Service::SlackRails.delete_by_chat_in_channel(ts: params[:ts], channel_id: channel_id)
    set_todolist
  end

  private

  def todo_works
    @todo_works ||= set_todo_works
  end

  def set_todo_works
    todo_works = Service::TodoWork.new
    todo_works.channel = channel_name
    todo_works.selected_day = params[:selected_day][0] if params.include?(:selected_day)
    binding.pry
    todo_works
  end

  def channel_name
    @channel_name ||= params[:channel]
  end

  def set_todolist
    @todolist = todo_works.todolist
  end

end
