class Together
  include ActiveModel::Model

  attr_accessor(
    :api_token,
    :query,
    :ts,
    :search_type,
  )

  def search
    case search_type
    when Constants::SlackRails::SearchTypes::LINK
      search_by_link
    when Constants::SlackRails::SearchTypes::QUERY
      search_by_query
    end
    self
  end

  def results_extracted
    return [] if results.blank?

    case search_type
    when Constants::SlackRails::SearchTypes::LINK
      results_by_link
    when Constants::SlackRails::SearchTypes::QUERY
      results_by_query
    end
  end

  private

  def search_by_query
    @results = slack.search_by_query_for_chat(query)
  end

  def search_by_link
    @results = slack.search_by_link_for_chat(query: query, ts: ts)
  end

  def results
    @results
  end

  def results_by_query
    results["messages"]["matches"].map do |res|
      {
        channel_id: res["channel"]["id"],
        channel_name: res["channel"]["name"],
        user_id: res["user"],
        user_name: res["username"],
        text: res["text"],
        permalink: res["permalink"],
        ts: res["ts"],
      }
    end.sort_by { |res| res[:ts] } rescue []
  end

  def results_by_link
    results["messages"]["matches"].map do |res|
      {
        channel_id: res["channel"]["id"],
        channel_name: res["channel"]["name"],
        user_id: res["user"],
        user_name: res["username"],
        text: res["text"],
        permalink: res["permalink"],
        ts: res["ts"],
      }
    end.sort_by { |res| res[:ts] } rescue []
  end

  def slack
    @slack ||= SlackRails::Application.new(api_token)
  end

end
