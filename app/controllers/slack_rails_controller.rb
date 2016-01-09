class SlackRailsController < ApplicationController
  before_action :set_user_image_list, only: [:search, :search_link]
  before_action :set_slack_markdown_processor
  before_action :set_query_select_list, only: [:index, :query, :channel, :save]
  before_action :set_channel_list

  def index
  end

  def query
  end

  def link
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

  def channel
    @channel = params[:channel]
  end

  def save
    if params.include?(:save)
      save_for_mysql
    elsif params.include?(:lodge)
      date = output_for_lodge
      filename = Time.new.strftime("%Y%m%d%H%M%S") + ".txt"
    end
    send_data(date, type: 'text/csv', filename: filename)
#    return render action: 'index'
  end

  private

  def save_for_mysql
    #TODO: MySQLへの保存処理
  end

  def output_for_lodge
    #TODO: lodgeへの出力処理
    lodge_support = Service::LodgeSupport.new(set_lodge_params)
    lodge_support.output_date('markdown')
  end

  def search_params
    params.require(:slack).permit(:channel, :user, :reaction, :keywords)
  end

  def search_link_params
    params.require(:slack).permit(:link)
  end

  def set_lodge_params
    params.permit(images: [], names: [], texts: [], channels: [], links: [], tss: [])
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
      on_slack_user_id: -> (uid) {
        user_list = set_user_list
        user_name = user_list.find {|user| user[1] == uid }[0]
        return {url: "#{TEAM_DIRECTORY_URL}/#{user_name}", text: user_name }
      },
      on_slack_channel_id: -> (uid){
        channel_list = set_channel_list
        channel_name = channel_list.find {|channel| channel[1] == uid }[0]
        return { url: '/', text: channel_name }
      },
    )
  end

  def set_query_select_list
    @reaction_list = Service::SlackRails.reaction_list
    set_user_list
    set_channel_list
  end

  def set_channel_list
    @channel_list ||= Service::SlackRails.channel_list
  end

  def set_user_list
    @user_list ||= Service::SlackRails.user_list
  end
end
