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

  private

  def result_messages
    if @result_messages.nil?
      client = set_slack_client
      @result_messages = client.search_messages(query: query)
    end
    @result_messages
  end

  def list_by(keyword)
    result_messages["messages"]["matches"].map do |result|
      if result["ts"].slice(0, result["ts"].index(".")).to_i >= today_ts
        if result["text"] =~ /\A#{keyword}::/
          [result["text"], result["ts"]]
        end
      end
    end.compact.sort { |a,b| a[1] <=> b[1] }
  end

  def query
    "in:#{channel}"
  end

  def set_slack_client
    Slack.configure { |config| config.token = SLACK_API_TOKEN }
    Slack.client
  end

  def today_ts
    today = Date.new
    times = Time.mktime(today.year, today.month, today.day, 0, 0, 0)
    times.to_i
  end

end
