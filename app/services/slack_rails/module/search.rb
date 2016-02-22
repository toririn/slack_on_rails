module SlackRails::Module::Search
  include SlackRails::Module::Base

  # Chat検索

  def search_by_query_for_chat(query, count = SlackRails::SEARCH_MAX_COUNT)
    slack_client.search_messages(query: query, count: count)
  rescue => ex
    []
  end

  def search_by_link_for_chat(query: , ts: "")
    results = search_by_query_for_chat(query)
    ts_d = ts.delete("p")
    count = 0
    results["messages"]["matches"] = results["messages"]["matches"].map do |result|
      if result["ts"].delete(".") >= ts_d
        result
        count++
      end

      if count == 100
        break
      end
    end.compact
    results
  rescue => ex
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
    []
  end

  # Channel検索

  def search_by_channel_for_name(name)
    channel_list = get_channel_list
    channel_list.select {|ch| [ch] if ch[0] =~ /#{name}/ }
  rescue => ex
    []
  end

  def search_by_channel_for_id(id)
    channel_list = get_channel_list
    channel_list.find {|ch| ch[1] == id }
  rescue => ex
    []
  end
end
