class SlackRailsController < ApplicationController
  def index
    @user_list = SlackRails.user_list
    @channel_list = SlackRails.channel_list
    @reaction_list = SlackRails.reaction_list
  end

  def search
    @user_list = SlackRails.user_list
    @channel_list = SlackRails.channel_list
    @reaction_list = SlackRails.reaction_list

    @slack_search_form = Search::SlackSearchForm.new(search_params)
    @results = @slack_search_form.search
    render 'index'
  end

  private

  def search_params
    params.require(:slack).permit(:channel, :user, :reaction, :keywords)
  end

  def type_of(result)
    self["type"]
  end

  def text_of(result)
    self["text"]
  end

  def channel_name_of(result)
    self["channel"]["name"]
  end

  def messages_matched_of(result)
    self["messages"]["matches"]
  end

end
