class SlackAppController < ApplicationController
  before_action :set_slack_markdown_processor
  before_action :set_channel_list

  private

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

  def set_channel_list
    @channel_list ||= slack.channel_list
  end

  def set_user_list
    @user_list ||= slack.user_list
  end

  def slack
    @slack ||=Service::SlackRails.new(session[:token])
  end

end
