class TodoManagementsController < SlackAppController
  include TodoManagementsParameter
  include TodoManagementsCallback

  def index
    @validate = Validators::TodoWork.new(params.permit(:channel))
    return render if @validate.has_error?
    set_todo_management_list_param
  end

  def modify
    set_todo_management_list_param
    render action: :index
  end

  def complete_task
    channel_id = Channel.convert(name: @channel_name)
    @result_update = slack.update_by_chat_in_channel(text: "#{Constants::TodoManagements::Keywords::DONE}::#{params[:text]}", ts: params[:ts], channel_id: channel_id)
    @result_post = slack.post_by_chat_in_channel(text: "#{Constants::TodoManagements::Keywords::DONE}::#{params[:text]}", username: session[:user][:name], channel_id: channel_id) if @result_update
    set_todo_management_list_param
  end

  def report
    set_todo_managements_report_param
    data = @todo_managements_report.output_data
    filename = "作業報告" + params[:report_date] + ".txt"
    send_data(data, type: 'text/csv', filename: filename)
  end
end
