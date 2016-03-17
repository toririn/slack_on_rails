module SlackRails::Module::Search
  include SlackRails::Module::Base

  # Chat検索

  def search_by_query_for_chat(query, count = Constants::SlackRails::SEARCH_MAX_COUNT)
    slack_client.search_messages(query: query, count: count, sort: :timestamp, sort_dir: :asc)
  rescue => ex
    p ex
    []
  end

  def search_by_link_for_chat(query: , ts: "", count: nil)
    results = search_by_query_for_chat(query)
    ts_d = ts.delete("p")
    result_num = 0
    result_max_num = count || Constants::SlackRails::SEARCH_RESULT_MAX_COUNT
    results["messages"]["matches"] = results["messages"]["matches"].map do |result|
      next if result_num == result_max_num
      if result["ts"].delete(".") >= ts_d
        result_num += 1
        result
      end
    end.compact
    results
  rescue => ex
    p ex
    []
  end

  def search_by_reaction_for_chat(user_id: , reaction_type: )
    chats = []
    reactions = get_reactions_list(user_id)
    reactions["items"].each.with_index do |item, idx|
      item["message"]["reactions"].each do |reaction|
        if reaction["name"] == reaction_type
          f = reactions["items"][idx]["message"]
          chats << {user: f["user"], text: f["text"], ts: f["ts"], permalink: f["permalink"] }
        end
      end
    end
    chats
  rescue => ex
    p ex
    []
  end

  # Channel検索

  def search_by_channel_for_name(name)
    channel_list = get_channel_list
    channel_list.select {|ch| [ch] if ch[0] =~ /#{name}/ }
  rescue => ex
    p ex
    []
  end

  def search_by_channel_for_id(id)
    channel_list = get_channel_list
    channel_list.find {|ch| ch[1] == id }
  rescue => ex
    p ex
    []
  end

  # 引数のチャンネルIDのチャンネルに参加しているユーザ全員のユーザIDを返す
  # 戻り型：Array
  # 例：["UH0098IYU", "UC0912YII", "U12SDF19", ...]
  def channel_joined_member_ids(channel_id)
    channels_info = get_channels_info(channel_id)
    channels_info["channel"]["members"].map do |member_id|
      member_id
    end.sort
  rescue => ex
    p ex
    []
  end
end
