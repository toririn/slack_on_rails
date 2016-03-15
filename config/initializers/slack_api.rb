require 'slack'
Slack.configure { |config| config.token = Constants::SLACK_API_TOKEN }
SLACK_OWNER = Slack.client
