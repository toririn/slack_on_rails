class SlackRailsController < ApplicationController

  def index
    @slack_search_form = Search::SlackSearchForm.new
  end

  def search

    render 'index'
  end

end
