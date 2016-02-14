module SlackRailsHelper
  # Slackの検索結果からチャンネル名の一覧を抽出する
  # e.g. [ "CH00003", "general", ...]
  def channel_name_list(search_results)
    search_results["messages"]["matches"].map do |res|
      [res["channel"]["id"], res["channel"]["name"]]
    end rescue []
  end

  def options_channel_list(channel_list)
    channel_list.map do |channel|
     [channel[0], channel[0]] 
    end.unshift(["全部", "all"]) rescue []
  end

  def options_user_list(user_list)
    user_list.map do |user|
     [user[0], user[0]] 
    end.unshift(["全部", "all"]) rescue []
  end

  def options_reaction_list(reaction_list)
    reaction_list.map do |reaction|
     [reaction[0], reaction[0]]
    end.unshift(["全部", "all"]) rescue []
  end
end
