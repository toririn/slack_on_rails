class TogetherQueryParameter
  attr_accessor(
    :channel,
    :user,
    :reaction,
    :keywords,
  )

  def query
    "#{keywords} #{query_channel} #{query_user}"
  end

  def search_words
    keywords.split(" |　").join("|")
  end

  private

  def query_channel
    if channel == "all"
      ""
    else
      "in:#{channel}"
    end
  end

  def query_user
    if user == "all"
      ""
    else
      "from:#{user}"
    end
  end
end
