require 'slack'
Slack.configure { |config| config.token = Constants::SLACK_API_TOKEN }
SLACK_OWNER = Slack.client
def set_channel_list
  channels = SLACK_OWNER.channels_list
  channels["channels"].map do |channel|
    [channel["name"], channel["id"]]
  end.sort {|a, b| a[0] <=> b[0] }
end

def set_user_list
  users = SLACK_OWNER.users_list
  users["members"].map do |user|
    [user["name"], user["id"]]
  end.sort {|a, b| a[0] <=> b[0] }
end


SLACK_CHANNEL_LIST = set_channel_list
SLACK_USER_LIST = set_user_list

SLACK_MARKDOWN_PROCESSOR = SlackMarkdown::Processor.new(
  asset_root: Constants::SlackRails::IMAGE_ROOT_PATH,
  on_slack_user_id: -> (uid) {
    user_list = SLACK_USER_LIST
    user_name = user_list.find {|user| user[1] == uid }[0]
    return {url: "#{Constants::TEAM_DIRECTORY_URL}/#{user_name}", text: user_name }
  },
  on_slack_channel_id: -> (uid){
    channel_list = SLACK_CHANNEL_LIST
    channel_name = channel_list.find {|channel| channel[1] == uid }[0]
    return { url: '/', text: channel_name }
  },
  )

