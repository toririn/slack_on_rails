require 'slack'
class Service::SlackRails
  include ActiveModel::Model

  attr_accessor(
    :api_token
  )

  def initialize(token)
    api_token = token
    Slack.configure { |config| config.token = api_token }
    @slack = Slack.client
  end

  def channel_list
    channel_list = get_channel_list
    if channel_list
      #channel名で並び替える
      channel_list.sort {|a, b| a[0] <=> b[0] }
    else
      []
    end
  end

  def channel_list_by(name: nil, id: nil )
    channels = channel_list
    if name
      channels.select {|ch| [ch] if ch[0] =~ /#{name}/ }
    elsif id
      channels.find {|ch| ch[1] == id }
    end
  end

  def user_list
    user_list = get_user_list
    if user_list
      user_list
    else
      []
    end
  end

  def user_image_list
    user_image_list = get_user_image_list.to_h
    user_image_list || []
  end

  def search_by_query(query)
    client = set_slack_client
    client.search_messages(query: query, count: 350)
  end

  def search_by_link(query, ts="")
    results = search_by_query(query)
    ts_d = ts.delete("p")
    results["messages"]["matches"] = results["messages"]["matches"].map do |result|
      if result["ts"].delete(".") >= ts_d
        result
      end
    end.compact
    results
  end

  def delete_by_chat_in_channel(ts: , channel_id:)
    client = set_slack_client
    result = client.chat_delete(ts: ts, channel: channel_id)
    result["ok"]
  end

  def channel_name_to_id(name: )
    channel_list = get_channel_list
    channel_list.find{ |ch| ch[0] == name }[1]
  end

  def added_reaction_chats(user_id: , reaction_type: )
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
  end

  private

  def set_slack_client
    return @slack if @slack.present?
    Slack.configure { |config| config.token = api_token }
    @slack = Slack.client
  end

  def get_channel_list
    client = set_slack_client
    channels = client.channels_list
    channels["channels"].map do |channel|
      [channel["name"], channel["id"]]
    end
  end

  def get_user_list
    client = set_slack_client
    users = client.users_list
    users["members"].map do |user|
      [user["name"], user["id"]]
    end
  end

  def get_user_image_list
    client = set_slack_client
    users = client.users_list
    users["members"].map do |user|
      [user["name"], user["profile"]["image_24"]]
    end
  end

  def get_reactions_list(user_id)
    client = set_slack_client
    client.reactions_list(user: user_id, count: 20)
  end
end
