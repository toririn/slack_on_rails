class Togethers::QuerySearchsController < Togethers::SearchsController
  before_action :set_query_select_list, only: [:index]

  def index
  end

  def search
    @validate = Validators::SlackSearch.new(search_params)
    return render if @validate.has_error?

    parameters = set_query_params
    together = Together.new(api_token: session[:token], query: parameters.query, search_type: Constants::SlackRails::SearchTypes::QUERY)
    @results = together.search.results_extracted
  end

  private

  def set_query_select_list
    set_user_list
    set_channel_list
  end

  def search_params
    params.require(:slack).permit(:channel, :user, :reaction, :keywords)
  end

  def set_query_params
    TogetherQueryParameter.new.tap do |p|
      p.channel = params[:slack][:channel]
      p.user = params[:slack][:user]
      p.reaction = params[:slack][:reaction]
      p.keywords = params[:slack][:keywords]
    end
  end
end
