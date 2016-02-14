module SlackApplication
  extend ActiveSupport::Concern

  included do
    before_action :set_slack_markdown_processor
    before_action :set_channel_list
  end

  private

  def set_slack_markdown_processor
    @slack_markdown_processor ||= SLACK_MARKDOWN_PROCESSOR
  end

  def set_channel_list
    @channel_list ||=SLACK_CHANNEL_LIST
  end

  def set_user_list
    @user_list ||=SLACK_USER_LIST
  end

  def slack
    @slack ||=SlackRails::Application.new(session[:token])
  end
end
