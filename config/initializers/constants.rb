module Constants
  ## Constants::AAAでアクセス可能
  # TEAMのSLACK_API_TOKEN
  SLACK_API_TOKEN = ENV['SLACK_API_TOKEN']
  # TEAMのSLACKのCLIENT_ID
  SLACK_CLIENT_ID = ENV['SLACK_CLIENT_ID']
  # TEAMのSECRET_KEY
  SLACK_SECRET = ENV['SLACK_SECRET']
  # 検索結果が0件だったときのエラーメッセージ
  RESULTS_EMPTY_MESSAGE = "条件に一致するチャットが見つかりませんでした。\n再度条件を変更して検索してください。"
  # TEAMのディレクトリ
  TEAM_DIRECTORY_URL = ENV['SLACK_URL'] + "/team"
  # SLACK_ON_RAILSのTOKEN
  SLACK_ON_RAILS_TOKEN = ENV['SLACK_ON_RAILS_TOKEN']
  # アプリのルートパス
  ROOT_PATH = ENV['ROOT_PATH']

  # セッション関係
  module Sessions
    # セッションの保持期間(日)
    HOLDING_PERIOD = 10
 end

  # SlackRails関係
  module SlackRails
    # チャット検索の最大取得結果数
    SEARCH_MAX_COUNT = 1000
    # （トップページ）チェック項目の最大取得数
    CHECK_MAX_COUNT = 1000
    # 検索結果表示最大件数
    SEARCH_RESULT_MAX_COUNT = 500
    # 画像ファイルのパス
    IMAGE_ROOT_PATH = ENV["SLACK_ON_RAILS_IMAGE_ROOT_PATH"]
    # 検索可能チャンネル命名規則
    SEARCHABLE_CHANNEL_LIST = [/\Ageneral\Z/, /\Akb_/, /\Atimes_/, /\Axclub_i/, /\Arandom\Z/, /\Aict_/, /\Afaq_slack\Z/, /\Ahelpdesk_qa\Z/, /\Ainfo_security\Z/, /\Awotax_/, /_media\Z/, /-platform\Z/]

    # 検索タイプ関係
    module SearchTypes
      LINK = "link"
      QUERY = "query"
      REACTION = "reaction"
    end

    # Slackのリアクション関係
    module SlackReactions
      EYES = "eyes"
      LICON = "heart"
    end
  end

  # TODOタスク管理系
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
    # タスク管理での過去のチャット取得件数
    SEARCH_MAX_COUNT = 1000
  end

  module Channels
    module Errors
      NOT_INTRODUCTION = "チャンネル紹介が登録されていません。"
    end
  end

  module Otacks
    module Errors
      EMPTY_SEARCH_RESULT = "どうやらどのおたっくチャンネルにも参加していないようです。"
    end
  end
end
