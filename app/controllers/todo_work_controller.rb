class TodoWorkController < SlackAppController

  def index
    @channel_name = params[:channel]
    @validate = Validators::TodoWork.new(params.permit(:channel))
    return render if @validate.has_error?

    todo_works = set_todo_works
    @todo_list = todo_works.todo_list
    @do_list = todo_works.do_list
    @done_list = todo_works.done_list
    @comment_list = todo_works.comment_list
  end

  def modify

  end

  private

  def set_todo_works
    todo_works = Service::TodoWork.new
    todo_works.channel = @channel_name
    todo_works
  end

end
