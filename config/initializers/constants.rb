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

module SlackRails
  # チャット検索の最大取得結果数
  SEARCH_MAX_COUNT = 100
  # （トップページ）チェック項目の最大取得数
  CHECK_MAX_COUNT = 20
  module SearchType
    LINK = "link"
    QUERY = "query"
    REACTION = "reaction"
  end
end
module SlackReaction
  EYES = "eyes"
  LICON = "heart"
end

module TodoManagements
  module Keywords
    ALL_SEARCH = %w(TASK BOOK)
    TASK = "TASK"
    TODO = "TODO"
    DO = "DO"
    DONE = "DONE"
    PEND = "PEND"
    SAY = "SAY"
    BOOK = "BOOK"
  end
end
