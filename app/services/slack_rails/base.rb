require 'slack'
class SlackRails::Base
  attr_accessor(
    :api_token,
  )

  def initialize(token)
    api_token = token
    Slack.configure { |config| config.token = api_token }
    @slack_client = Slack.client
  end

  private

  def slack_client
    @slack_client
  end
end
