require 'slack'
class Service::TodoWork
  include Service::Base::TodoWork

  def todo_list
    list_by("TODO")
  end

  def do_list
    list_by("DO")
  end

  def done_list
    list_by("DONE")
  end

  def pend_list
    list_by("PEND")
  end

  def comment_list
    list_by("SAY")
  end

  def task_list
    list_by_task
  end

  def book_list
    list_by_book
  end

  private

  def result_messages
    if @result_messages.nil?
      client = set_slack_client
      @result_messages = client.search_messages(query: query, count: 1000)
    end
    @result_messages
  end

  def list_by(keyword)
    result_messages["messages"]["matches"].map do |result|
      res_ts = result["ts"].slice(0, result["ts"].index(".")).to_i
      if res_ts >= day_ts && res_ts <= (day_ts + add_1day_ts)
        if result["text"] =~ /\A#{keyword}::/i
          [result["text"], result["ts"]]
        end
      end
    end.compact.sort { |a,b| a[1] <=> b[1] }
  end

  def list_by_task
    result_messages["messages"]["matches"].map do |result|
      if result["text"] =~ /\ATASK::/i
        [result["text"], result["ts"]]
      end
    end.compact.sort { |a,b| a[1] <=> b[1] }
  end

  def list_by_book
    result_messages["messages"]["matches"].map do |result|
      if result["text"] =~ /\A((BOOK)|(STOCK))::/i
        [result["text"], result["ts"]]
      end
    end.compact.sort { |a,b| a[1] <=> b[1] }
  end

  def query
    "in:#{channel}"
  end

  def set_slack_client
    SLACK
  end

  def today_ts
    today = Time.new
    times = Time.mktime(today.year, today.month, today.day, 0, 0, 0)
    times.to_i
  end

  # 選択した日付があればその秒数を。なければnilを返す。
  def selected_day_ts
    return nil if selected_day.nil?
    # paramの日付がmm/dd/yyyy hh:MM;ss で渡されるため以下で分離
    day_temp = selected_day.slice(0, selected_day.index(" "))
    month, day, year = day_temp.split("/")
    times = Time.mktime(year, month, day, 0, 0, 0)
    times.to_i
  end

  def day_ts
    selected_day_ts || today_ts
  end

  def add_1day_ts
    24*60*60
  end

end
