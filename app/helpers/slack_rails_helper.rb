module SlackRailsHelper
  # Slackの検索結果からチャンネル名の一覧を抽出する
  # e.g. [ "CH00003", "general", ...]
  def channel_name_list(search_results)
    search_results["messages"]["matches"].map do |res|
      [res["channel"]["id"], res["channel"]["name"]]
    end
  end

  # Slackの検索結果からテーブルに表示する内容を抽出する。
  # e.g.["CH0003", "general", "UH0001", "Rails君", "チャットの内容", "http://〜〜〜"]
  def extract_for_table(search_results)
    search_results["messages"]["matches"].map do |res|
      [res["channel"]["id"], res["channel"]["name"], res["user"], res["username"], res["text"], res["permalink"]]
    end
  end

  # Slackの検索結果を全て表示させる。デバッグ用。
  def debug_for(search_results)
    search_results["messages"]["matches"].map do |res|
     p res
    end
  end

end
