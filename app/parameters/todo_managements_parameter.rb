module TodoManagementsParameter

  private

  def todo_management
    @todo_management ||= set_todo_management
  end

  def set_todo_management
    todo_management = TodoManagement.new(api_token: session[:token])
    # TODO parameterクラスを使用する
    todo_management.query = "in:#{@channel_name}"
    todo_management.selected_day = params[:selected_day][0] if params.include?(:selected_day)
    todo_management.search
  end

  def set_todo_management_list_param
    @todo_list = todo_management.results_extracted(Constants::TodoManagements::Keywords::TODO)
    @do_list = todo_management.results_extracted(Constants::TodoManagements::Keywords::DO)
    @done_list = todo_management.results_extracted(Constants::TodoManagements::Keywords::DONE)
    @task_list = todo_management.results_extracted(Constants::TodoManagements::Keywords::TASK)
  end
end
