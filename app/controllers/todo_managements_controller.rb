class TodoManagementsController < SlackAppController

  def index
    @channel_name = params[:channel]
    @validate = Validators::TodoWork.new(params.permit(:channel))
    return render if @validate.has_error?

    todo_management.search
    @todo_list = todo_management.results_extracted(todo_list)
    @do_list = todo_management.results_extracted(do_list)
    @done_list = todo_management.results_extracted(done_list)
    @comment_list = todo_management.results_extracted(comment_list)
    @book_list = todo_management.results_extracted(book_list)
    set_task_list
  end

  def modify
    @channel_name = params[:channel]

    todo_management.search
    @todo_list = todo_management.results_extracted(todo_list)
    @do_list = todo_management.results_extracted(do_list)
    @done_list = todo_management.results_extracted(done_list)
    @comment_list = todo_management.results_extracted(comment_list)
    @book_list = todo_management.results_extracted(book_list)
    set_task_list
    render action: 'index'
  end

  def delete_task
    channel_id = slack.channel_name_to_id(name: params[:channel])
    @result_delete = slack.delete_by_chat_in_channel(ts: params[:ts], channel_id: channel_id)
    set_task_list
  end

  private

  def todo_management
    @todo_management ||= set_todo_management
  end

  def set_todo_management
    todo_management = TodoManagement.new(api_token: session[:token])
    # TODO parameterクラスを使用する
    todo_management.query = "in:#{channel_name}"
    todo_management.selected_day = params[:selected_day][0] if params.include?(:selected_day)
    todo_management
  end

  def channel_name
    @channel_name ||= params[:channel]
  end

  def set_task_list
    @task_list = todo_management.results_extracted(TodoManagements::Keywords::TASK)
  end

  def todo_list
    TodoManagements::Keywords::TODO
  end

  def do_list
    TodoManagements::Keywords::DO
  end

  def done_list
    TodoManagements::Keywords::DONE
  end

  def comment_list
    TodoManagements::Keywords::SAY
  end

  def book_list
    TodoManagements::Keywords::BOOK
  end

  def task_list
    TodoManagements::Keywords::TASK
  end

end
