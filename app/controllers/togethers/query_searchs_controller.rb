class Togethers::QuerySearchsController < Togethers::SearchsController

  def index
    set_user_list
    set_channel_list
  end

  def search
    @validate = ::FormValidators::QueryValidator.new(search_params)
    return if @validate.has_error?

    parameter = set_query_params
    together  = Together.new(api_token: session[:token], query: parameter.query, search_type: Constants::SlackRails::SearchTypes::QUERY, search_words: parameter.search_words)
    @results  = together.search.results_extracted
  end

  private

  def search_params
    params.require(:slack).permit(:channel, :user, :keywords)
  end

  def set_query_params
    Togethers::TogetherQueryParameter.new.tap do |p|
      p.channel  = params[:slack][:channel]
      p.user     = params[:slack][:user]
      p.reaction = params[:slack][:reaction]
      p.keywords = params[:slack][:keywords]
    end
  end
end
