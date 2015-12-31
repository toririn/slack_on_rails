class SlackRailsController < ApplicationController
  before_action :set_user_image_list, only: [:search, :search_link]
  before_action :set_slack_markdown_processor

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

  def search_link
    @validate = Validators::SlackSearchLink.new(search_link_params)
    return render 'search' if @validate.has_error?

    parameters = set_link_parameters
    @results = Service::SlackRails.search_by_link(parameters.query, parameters.ts)
    render 'search'
  end

  private

  def search_params
    params.require(:slack).permit(:channel, :user, :reaction, :keywords)
  end

  def search_link_params
    params.require(:slack).permit(:link)
  end

  def set_parameters
    parameters = Parameters::SlackSearch.new
    parameters.channel = params[:slack][:channel]
    parameters.user = params[:slack][:user]
    parameters.reaction = params[:slack][:reaction]
    parameters.keywords = params[:slack][:keywords]
    parameters
  end

  def set_link_parameters
    parameters = Parameters::SlackSearchLink.new
    parameters.link = params[:slack][:link]
    parameters
  end

  def set_user_image_list
    @user_image_list = Service::SlackRails.user_image_list
  end

  def set_slack_markdown_processor
    @slack_markdown_processor = SlackMarkdown::Processor.new(
      asset_root: 'https://assets.github.com/images/icons/',
    )
  end
end
