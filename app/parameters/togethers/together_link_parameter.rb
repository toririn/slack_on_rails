class Togethers::TogetherLinkParameter
  attr_accessor(
    :link,
    :count,
  )

  def query
    "in:#{channel}"
  end

  def channel
    url_paths[2]
  end

  def ts
    url_paths[3]
  end

  def archives
    url_paths[1]
  end

  def count_num
    count.to_i
  end

  private

  def url
    URI.split(link)
  end

  def url_paths
    url[5].split("/")
  end
end
