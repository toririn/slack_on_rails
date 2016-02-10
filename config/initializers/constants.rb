module Constants
  ## Constants::AAAでアクセス可能
end
SLACK_API_TOKEN = ENV['SLACK_API_TOKEN']
SLACK_CLIENT_ID = ENV['SLACK_CLIENT_ID']
SLACK_SECRET = ENV['SLACK_SECRET']
RESULTS_EMPTY_MESSAGE = "条件に一致するチャットが見つかりませんでした。\n再度条件を変更して検索してください。"
TEAM_DIRECTORY_URL = ENV['SLACK_URL'] + "/team"
SLACK_ON_RAILS_TOKEN = ENV['SLACK_ON_RAILS_TOKEN']
SLACK_ON_RAILS_TOKEN = ENV['SLACK_ON_RAILS_TOKEN']
ROOT_PATH = ENV['ROOT_PATH']

module Sessions
  HOLDING_PERIOD = 10
end

module SlackReaction
  EYES = "eyes"
  LICON = "heart"
end
