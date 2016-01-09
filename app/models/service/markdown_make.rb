class Service::MarkdownMake


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
    html
  end

  def self.ts_to_date(ts)
    ts_temp = ts.slice(0, ts.index(".")).to_i
    date = Time.at(ts_temp)
    date.strftime("%Y/%m/%d %H:%M:%S")
  end

  def self.slack_markdown_processor
    @@slack_markdown_processor ||= SlackMarkdown::Processor.new(
      asset_root: 'https://assets.github.com/images/icons/',
      on_slack_user_id: -> (uid) {
        user_list = set_user_list
        user_name = user_list.find {|user| user[1] == uid }[0]
        return {url: "#{TEAM_DIRECTORY_URL}/#{user_name}", text: user_name }
      },
      on_slack_channel_id: -> (uid){
        channel_list = set_channel_list
        channel_name = channel_list.find {|channel| channel[1] == uid }[0]
        return { url: '/', text: channel_name }
      },
    )
  end

  def self.set_channel_list
    @@channel_list ||= Service::SlackRails.channel_list
  end

  def self.set_user_list
    @@user_list ||= Service::SlackRails.user_list
  end
end
