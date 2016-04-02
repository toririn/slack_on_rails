module SlackApplication
  extend ActiveSupport::Concern
  include CommonParameter

  included do
    before_action :set_slack_markdown_processor
    before_action :set_channel_list
  end
end
