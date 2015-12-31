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
    return [] if search_results["messages"].nil?
    search_results["messages"]["matches"].map do |res|
      [res["channel"]["id"], res["channel"]["name"], res["user"], res["username"], res["text"], res["permalink"]]
    end.sort { |a, b| a[5] <=> b[5] }
  end

  def options_channel_list(channel_list)
    channel_list.map do |channel|
     [channel[0], channel[0]] 
    end.unshift(["全部", "all"])
  end

  def options_user_list(user_list)
    user_list.map do |user|
     [user[0], user[0]] 
    end.unshift(["全部", "all"])
  end

  def options_reaction_list(reaction_list)
    reaction_list.map do |reaction|
     [reaction[0], reaction[0]]
    end.unshift(["全部", "all"])
  end

  # Slackの検索結果を全て表示させる。デバッグ用。
  def debug_for(search_results)
    search_results["messages"]["matches"].map do |res|
     p res
    end
  end

end
