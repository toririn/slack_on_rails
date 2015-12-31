require 'slack'
class Service::SlackRails < ActiveRecord::Base
  scope :channel_list, -> {
    channel_list = get_channel_list
    if channel_list
      channel_list
    else
      []
    end
  }

  scope :user_list, -> {
    user_list = get_user_list
    if user_list
      user_list
    else
      []
    end
  }

  scope :user_image_list, -> {
    user_image_list = get_user_image_list.to_h
    user_image_list || []
  }

  scope :reaction_list, ->{
    reaction_list = get_reaction_list
    if reaction_list
      reaction_list.uniq
    else
      []
    end
  }

  scope :search_by_query, ->(query) {
    client = set_slack_client
    client.search_messages(query: query)
  }

  scope :search_by_link, ->(query, ts="") {
    client = set_slack_client
    results = client.search_messages(query: query)
    ts_d = ts.delete("p")
    results["messages"]["matches"] = results["messages"]["matches"].map do |result|
      if result["ts"].delete(".") >= ts_d
        result
      end
    end.compact
    results
  }

  private

  def self.set_slack_client
    Slack.configure { |config| config.token = SLACK_API_TOKEN }
    Slack.client
  end

  def self.get_channel_list
    client = set_slack_client
    channels = client.channels_list
    channels["channels"].map do |channel|
      [channel["name"], channel["id"]]
    end
  end

  def self.get_user_list
    client = set_slack_client
    users = client.users_list
    users["members"].map do |user|
      [user["name"], user["id"]]
    end
  end

  def self.get_user_image_list
    client = set_slack_client
    users = client.users_list
    users["members"].map do |user|
      [user["name"], user["profile"]["image_24"]]
    end
  end

  def self.get_reaction_list
    client = set_slack_client
    items_with_reactions = client.reactions_list
    items_with_reactions["items"].map do |item|
      [item["message"]["reactions"].first["name"], item["message"]["reactions"].first["name"]]
    end
  end
end
