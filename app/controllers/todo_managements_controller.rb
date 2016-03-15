class TodoManagementsController < SlackAppController

  def index
    @channel_name = params[:channel]
    @validate = Validators::TodoWork.new(params.permit(:channel))
    return render if @validate.has_error?

    set_todo_management_list
  end

  def modify
    @channel_name = params[:channel]

    set_todo_management_list
    render action: :index
  end

  def delete_task
    @channel_name = params[:channel]
    channel_id = slack.convert_to_id(channel: @channel_name)
    @result_delete = slack.delete_by_chat_in_channel(ts: params[:ts], channel_id: channel_id)
    set_task_list
  end

  def complete_task
    @channel_name = params[:channel]
    channel_id = slack.convert_to_id(channel: @channel_name)
    @result_update = slack.update_by_chat_in_channel(text: "DONE::#{params[:text]}", ts: params[:ts], channel_id: channel_id)
    @result_post = slack.post_by_chat_in_channel(text: "DONE::#{params[:text]}", username: session[:user]["name"], channel_id: channel_id) if @result_update
    set_task_list
  end

  private

  def todo_management
    @todo_management ||= set_todo_management
  end

  def set_todo_management
    todo_management = TodoManagement.new(api_token: session[:token])
    # TODO parameterクラスを使用する
    todo_management.query = "in:#{@channel_name}"
    todo_management.selected_day = params[:selected_day][0] if params.include?(:selected_day)
    todo_management
  end

  def set_todo_management_list
    todo_management.search
    @todo_list = todo_management.results_extracted(todo)
    @do_list = todo_management.results_extracted(doing)
    @done_list = todo_management.results_extracted(done)
    @comment_list = todo_management.results_extracted(comment)
    @book_list = todo_management.results_extracted(book)
    set_task_list
  end

  def set_task_list
    @task_list = todo_management.results_extracted(task)
  end

  def todo
    Constants::TodoManagements::Keywords::TODO
  end

  def doing
    Constants::TodoManagements::Keywords::DO
  end

  def done
    Constants::TodoManagements::Keywords::DONE
  end

  def comment
    Constants::TodoManagements::Keywords::SAY
  end

  def book
    Constants::TodoManagements::Keywords::BOOK
  end

  def task
    Constants::TodoManagements::Keywords::TASK
  end

end
