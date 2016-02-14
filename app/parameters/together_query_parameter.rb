class TogetherQueryParameter
  attr_accessor(
    :channel,
    :user,
    :reaction,
    :keywords,
  )

  def query
    "#{query_keywords} #{query_channel} #{query_user}"
  end

  private

  def query_keywords
    if split_keywords.size == 1
      keywords
    else
      keywords
    end
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
      "from:#{user}"
    end
  end

  def split_keywords
    keywords.split(/ |　/)
  end
end
