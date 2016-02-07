require 'slack'
Slack.configure { |config| config.token = SLACK_API_TOKEN }
SLACK = Slack.client
