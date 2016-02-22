class TogetherController < SlackAppController

  before_action :set_user_image_list, only: [:search, :search_link]
  before_action :set_query_select_list, only: [:index, :query, :channel, :save]

  def top
    @user_name = session[:user]["name"]
    @eyes_chats = slack.search_by_reaction_for_chat(user_id: session[:user]["id"], reaction_type: Constants::SlackRails::SlackReactions::EYES)
  end

  def index
  end

  def query
  end

  def channel
    @channel = params[:channel]
  end

  def link
  end

  def search
    @validate = Validators::SlackSearch.new(search_params)
    return render if @validate.has_error?

    parameters = set_query_parameters
    together = Together.new(api_token: session[:token], query: parameters.query, search_type: Constants::SlackRails::SearchTypes::QUERY)
    @results = together.search.results_extracted
  end

  def search_link
    @validate = Validators::SlackSearchLink.new(search_link_params)
    return render 'search' if @validate.has_error?

    parameters = set_link_parameters
    together = Together.new(api_token: session[:token], query: parameters.query, ts: parameters.ts, search_type: Constants::SlackRails::SearchTypes::LINK)
    @results = together.search.results_extracted

    render :search
  end

  def save
    if params.include?(:save)
      save_for_mysql
    elsif params.include?(:lodge)
      date = output_for_lodge
      filename = Time.new.strftime("%Y%m%d%H%M%S") + ".txt"
    end
    send_data(date, type: 'text/csv', filename: filename)
  end

  private

  def save_for_mysql
    #TODO: MySQLへの保存処理
  end

  def output_for_lodge
    lodge_support = Outputs::LodgeSupport.new(set_lodge_params)
    lodge_support.output_date('markdown')
  end

  def set_user_image_list
    @user_image_list = slack.user_image_list
  end


  def set_query_select_list
    set_user_list
    set_channel_list
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

  def set_query_parameters
    TogetherQueryParameter.new.tap do |p|
      p.channel = params[:slack][:channel]
      p.user = params[:slack][:user]
      p.reaction = params[:slack][:reaction]
      p.keywords = params[:slack][:keywords]
    end
  end

  def set_link_parameters
    TogetherLinkParameter.new.tap do |p|
      p.link = params[:slack][:link]
    end
  end
end
