module TodoManagementDecorator
  def results_extracted(keyword)
    return [] if @results.blank?

    s_keyword = keyword.to_s
    if Constants::TodoManagements::Keywords::ALL_SEARCH.include? s_keyword
      results_all_ts_by(s_keyword)
    else
      results_by(s_keyword)
    end
  end

  private

  def results_by(keyword)
    @results["messages"]["matches"].map do |result|
      chat_ts_to_i = result["ts"].slice(0, result["ts"].index(".")).to_i
      if selected_day_period?(chat_ts_to_i)
        if result["text"] =~ /\A#{keyword}::/i
          { text: result["text"], ts: result["ts"] }
        end
      end
    end.compact.sort_by {|res| res[:ts] }
  end

  def results_all_ts_by(keyword)
    @results["messages"]["matches"].map do |result|
      if result["text"] =~ /\A#{keyword}::/i
        { text: result["text"], ts: result["ts"] }
      end
    end.compact.sort_by {|res| res[:ts] }
  end

  def selected_day_to_i
    return Time.zone.now.beginning_of_day.to_i if selected_day.nil?
    # paramの日付がmm/dd/yyyy hh:MM;ss で渡されるため以下で分離
    month, day, year = selected_day.slice(0, selected_day.index(" ")).split("/")
    Time.zone.local(year, month, day).to_i
  end

  def selected_day_period?(chat_ts_to_i)
    chat_ts_to_i >= selected_day_to_i && chat_ts_to_i <= (selected_day_to_i + 1.day.to_i)
  end
end
