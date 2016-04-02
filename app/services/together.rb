class Together
  include ActiveModel::Model

  MATCH_TYPES  = ["previous", "previous_2", "next", "next_2"]
  MATCH_KEYS   = ["user", "username", "ts", "text"]

  attr_accessor(
    :api_token,
    :query,
    :ts,
    :search_type,
    :count,
    :search_words,
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
    return [] if @results.blank?

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
    @results = slack.search_by_link_for_chat(query: query, ts: ts, count: count)
  end

  def results_by_query
    @results["messages"]["matches"].map do |res|
      user, username, ts, text = match_result(res)
      next if [user, username, ts].any? {|param| param.nil? }
      {
        channel_id: res["channel"]["id"],
        channel_name: res["channel"]["name"],
        user_id: user,
        user_name: username,
        text: text,
        permalink: res["permalink"],
        ts: ts,
      }
    end.compact.uniq {|res| res[:text]}.sort_by {|res| res[:ts] } rescue []
  end

  def results_by_link
    @results["messages"]["matches"].map do |res|
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

  # 検索結果から検索したワードが含まれているハッシュを返す。
  def match_result(result)

    # 検索結果にワードが含まれていたらそのまま返す
    if result["text"] =~ /#{search_words}/
      return MATCH_KEYS.map {|key| result[key] }
    end

    # 検索結果の前後2件を検索して結果を返す
    param = catch(:exit) do
      MATCH_TYPES.each do |type|
        res = result[type]
        next if res.nil?
        throw :exit, MATCH_KEYS.map {|key| res[key] } if res["text"] =~ /#{search_words}/
      end
    end
    # 検索結果のテキストに検索文字列が存在していれば結果を返す。
    return param if  param != MATCH_TYPES
    nil
  rescue => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join(String::LF))
    nil
  end

end
