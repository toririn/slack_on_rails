class TodoManagementsController < SlackAppController
  include TodoManagementsParameter
  include TodoManagementsCallback

  def index
  end

  def show
    @validate = ::FormValidators::ChannelValidator.new(params.permit(:channel))
    return render if @validate.has_error?
    @selected_day_time = set_selected_day_time_param
    set_todo_management_list_param
  end

  def update
    channel_id = Channel.convert(name: @channel_name)
    @result_update = slack.update_by_chat_in_channel(text: "#{Constants::TodoManagements::Keywords::DONE}::#{params[:text]}", ts: params[:ts], channel_id: channel_id)
    @result_post = slack.post_by_chat_in_channel(text: "#{Constants::TodoManagements::Keywords::DONE}::#{params[:text]}", username: session[:user][:name], channel_id: channel_id) if @result_update
    set_todo_management_list_param
  end

  def create
    set_todo_managements_report_param
    data = @todo_managements_report.output_data
    filename = "作業報告" + params[:report_date] + ".txt"
    send_data(data, type: 'text/csv', filename: filename)
  end
end
