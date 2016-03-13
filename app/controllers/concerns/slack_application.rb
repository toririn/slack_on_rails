module SlackApplication
  extend ActiveSupport::Concern

  included do
    before_action :set_slack_markdown_processor
    before_action :set_channel_list
  end

  private

  def set_slack_markdown_processor
    @slack_markdown_processor ||= slack_markdown_processor_create
  end

  def set_channel_list
    @channel_list ||= Channel.pluck(:name, :id)
  end

  def set_user_list
    @user_list ||= User.pluck(:name, :id)
  end

  def slack
    @slack ||=SlackRails::Application.new(session[:token])
  end

  def slack_markdown_processor_create
    SlackMarkdown::Processor.new(
      asset_root: Constants::SlackRails::IMAGE_ROOT_PATH,
      on_slack_user_id: -> (uid) {
        user_list = set_user_list
        user_name = user_list.find {|user| user[1] == uid }[0] rescue "user not found"
        return {url: "#{Constants::TEAM_DIRECTORY_URL}/#{user_name}", text: user_name }
      },
      on_slack_channel_id: -> (uid){
        channel_list = set_channel_list
        channel_name = channel_list.find {|channel| channel[1] == uid }[0] rescue "channel not found"
        return { url: '/', text: channel_name }
      },
    )
  end
end
