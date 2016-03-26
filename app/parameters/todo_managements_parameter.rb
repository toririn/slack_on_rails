module TodoManagementsParameter

  private

  def set_channel_name_param
    @channel_name = params[:channel]
  end

  def set_selected_day_param
    @selected_day = params[:past_day][0] if params.include?(:past_day)
  end

  def set_todo_management_param
    @todo_management = TodoManagement.new(api_token: session[:token])
    @todo_management.query = "in:#{@channel_name}"
    @todo_management.selected_day = @selected_day
    @todo_management.search
  end

  def set_todo_management_list_param
    @todo_list = @todo_management.results_extracted(Constants::TodoManagements::Keywords::TODO)
    @do_list = @todo_management.results_extracted(Constants::TodoManagements::Keywords::DO)
    @done_list = @todo_management.results_extracted(Constants::TodoManagements::Keywords::DONE)
    @task_list = @todo_management.results_extracted(Constants::TodoManagements::Keywords::TASK)
  end

  def set_todo_managements_report_param
    @todo_managements_report ||= Outputs::TodoManagementsReport.new(
      todo_list: params[:todo_list],
      done_work_list: params[:done_work_list],
      done_time_list: params[:done_time_list],
      user_name: session[:user][:name],
      report_date: params[:report_date],
    )
  end

  def set_selected_day_time_param
    return if @selected_day.blank?
    # paramの日付がmm/dd/yyyy hh:MM;ss で渡されるため以下で分離
    month, day, year = @selected_day.slice(0, @selected_day.index(" ")).split("/")
    Time.zone.local(year, month, day)
  end
end
