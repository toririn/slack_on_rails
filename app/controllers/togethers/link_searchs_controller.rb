class Togethers::LinkSearchsController < Togethers::SearchsController

  def index
    @count_candidate = { "10" => 10, "50" => 50, "100" => 100, "250" => 250, "500" => 500 }
  end

  def search
    @validate = Forms::LinkValidator.new(params.require(:slack).permit(:link))
    if @validate.has_error?
      @count_candidate = { "10" => 10, "50" => 50, "100" => 100, "250" => 250, "500" => 500 }
      return
    end
    parameters = set_link_params
    together   = set_together_params(parameters)
    @results   = together.search.results_extracted
  end

  private

  def set_link_params
    TogetherLinkParameter.new.tap do |p|
      p.link  = params[:slack][:link]
      p.count = params[:slack][:count]
    end
  end

  def set_together_params(parameters)
    Together.new(
      api_token:   session[:token],
      query:       parameters.query,
      ts:          parameters.ts,
      search_type: Constants::SlackRails::SearchTypes::LINK,
      count:       parameters.count_num,
    )
  end
end
