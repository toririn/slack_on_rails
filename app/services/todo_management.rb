class TodoManagement
  include ActiveModel::Model

  attr_accessor(
    :api_token,
    :query,
    :ts,
    :selected_day,
  )

  def search
    search_by_query
    self
  end

  def results_extracted(keyword)
    return [] if results.blank?

    s_keyword = keyword.to_s
    if Constants::TodoManagements::Keywords::ALL_SEARCH.include? s_keyword
      results_all_ts_by(s_keyword)
    else
      results_by(s_keyword)
    end
  end

  private

  def search_by_query
    @results = slack.search_by_query_for_chat(query, Constants::TodoManagements::SEARCH_MAX_COUNT )
  end

  def results
    @results
  end

  def results_by(keyword)
    results["messages"]["matches"].map do |result|
      res_ts = result["ts"].slice(0, result["ts"].index(".")).to_i
      if res_ts >= day_ts && res_ts <= (day_ts + add_1day_ts)
        if result["text"] =~ /\A#{keyword}::/i
          {text: result["text"], ts: result["ts"]}
        end
      end
    end.compact.sort_by {|res| res[:ts] }
  end

  def results_all_ts_by(keyword)
    results["messages"]["matches"].map do |result|
      if result["text"] =~ /\A#{keyword}::/i
        {text: result["text"], ts: result["ts"]}
      end
    end.compact.sort_by {|res| res[:ts] }
  end

  def slack
    @slack ||= SlackRails::Application.new(api_token)
  end

  def today_ts
    Time.zone.today.to_time.to_i
  end

  # 選択した日付があればその秒数を。なければnilを返す。
  def selected_day_ts
    return nil if selected_day.nil?
    # paramの日付がmm/dd/yyyy hh:MM;ss で渡されるため以下で分離
    day_temp = selected_day.slice(0, selected_day.index(" "))
    month, day, year = day_temp.split("/")
    Time.mktime(year, month, day, 0, 0, 0).to_i
  end

  def day_ts
    selected_day_ts || today_ts
  end

  def add_1day_ts
    24*60*60
  end
end
