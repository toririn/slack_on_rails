class Outputs::MarkdownMake

  def self.user_info(name, image_url)
    image_markdown = "![#{name}](#{image_url} \"#{name}\")"
    user_markdown = user_name(name)
    "#{image_markdown} **#{name}** "
  end

  def self.chat_info(channel_name, ts, link)
    "\-\-\-\- [*#{channel_name}* *#{ts_to_date(ts)}*](#{link} \"parmlink\")"
  end


  def self.title(title)
    "#{h1}#{title}"
  end

  def self.subtitle(title)
    "#{h2}#{title}"
  end

  def self.user_name(name)
    "#{list1}#{name}"
  end

  def self.user_image(image_url)
    "![](#{image_url} \"\")"
  end

  def self.channel_name(name)
    "#{h4}#{name}"
  end

  def self.parmlink(title)
    "#{h1}#{title}"
  end

  def self.text(text)
    text_html = slackmarkdown_to_html(text)
    html_to_markdown(text_html)
  end

  private

  def self.h1
    '# '
  end

  def self.h2
    '## '
  end

  def self.h3
    '### '
  end

  def self.h4
    '#### '
  end

  def self.list1
    '* '
  end

  def self.slackmarkdown_to_html(slackmarkdown)
    slack_markdown_processor.call(slackmarkdown)[:output].to_s.html_safe
  end

  def self.html_to_markdown(html)
    p = HTMLPage.new(contents: html)
    p.markdown
  end

  def self.ts_to_date(ts)
    ts_temp = ts.slice(0, ts.index(".")).to_i
    date = Time.at(ts_temp)
    date.strftime("%Y/%m/%d %H:%M:%S")
  end

  def self.slack_markdown_processor
    SLACK_MARKDOWN_PROCESSOR
  end

  def self.set_channel_list
    SLACK_CHANNEL_LIST
  end

  def self.set_user_list
    SLACK_USER_LIST
  end
end
