require 'slack'
class Search::SlackSearchForm
  include ActiveModel::Model

  attr_accessor(
    :channel,
    :user,
    :reaction,
    :keywords,
    :current_user,
  )

  validates :channe_id, presence: true
  validates :user_id, presence: true
  validates :reaction_id, presence: true
  #validates :keywords
  #validates :current_user_id

  def search
    Slack.configure { |config| config.token = SLACK_API_TOKEN }
    client = Slack.client
    results = client.search_messages(query: query)
    extract(results)
  end

  private

  def query
    "#{query_keywords} #{query_channel} #{query_user}"
  end

  def query_keywords
    if split_keywords.size == 1
      keywords
    else
      keywords
    end
  end

  def split_keywords
    keywords.split(/ |　/)
  end

  def query_channel
    if channel == "all"
      ""
    else
      "in:#{channel}"
    end
  end

  def guery_reaction
    if reaction == "all"
      ""
    else
      "in:#{reaction}"
    end
  end

  def query_user
    if user == "all"
      ""
    else
      "in:#{user}"
    end
  end

  def channel_name_list(results)
    results["messages"]["matches"].map do |result|
      [result["channel"]["id"], result["channel"]["name"]]
    end
  end

  def extract(results)
    results["messages"]["matches"].map do |result|
      [result["channel"]["id"], result["channel"]["name"], result["user"], result["username"], result["text"], result["permalink"]]
    end
  end

  def debug_for(results)
    results["messages"]["matches"].map do |result|
     p result 
    end
  end

end
