class SlackRailsController < ApplicationController
  def index
    @user_list = Service::SlackRails.user_list
    @channel_list = Service::SlackRails.channel_list
    @reaction_list = Service::SlackRails.reaction_list
  end

  def search
    @validate = Validators::SlackSearch.new(search_params)
    return render if @validate.has_error?

    parameters = set_parameters
    @results = Service::SlackRails.search_by_query(parameters.query)
  end

  private

  def search_params
    params.require(:slack).permit(:channel, :user, :reaction, :keywords)
  end

  def set_parameters
    parameters = Parameters::SlackSearch.new
    parameters.channel = params[:slack][:channel]
    parameters.user = params[:slack][:user]
    parameters.reaction = params[:slack][:reaction]
    parameters.keywords = params[:slack][:keywords]
    parameters
  end
end
