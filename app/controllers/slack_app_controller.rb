class SlackAppController < ApplicationController
  before_action :set_slack_markdown_processor
  before_action :set_channel_list

  private

  def set_slack_markdown_processor
    @slack_markdown_processor = SlackMarkdown::Processor.new(
      asset_root: 'https://assets.github.com/images/icons/',
    )
  end

  def set_channel_list
    @channel_list = Service::SlackRails.channel_list
  end
end
