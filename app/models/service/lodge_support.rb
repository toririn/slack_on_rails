class Service::LodgeSupport
  include Service::Base::LodgeSupport
  include ActiveModel::Model

  # ユーザにダウンロードさせる文字列（ファイル）を返すメソッド
  def output_date(type)
    if type == "html"
      output_html
    elsif type == "markdown"
      output_markdown.join("\n")
    end
  end

  #private

  # ユーザから送られてきた画像、ユーザ名、チャンネル名、チャット内容をくっつけた配列を返す
  # html_outputやmarkdown_outputsで使用する
  def join_params
    @joinparams ||= texts.map.with_index do |text, idx|
                      [
                        text,
                        images[idx],
                        names[idx],
                        channels[idx],
                        links[idx],
                        tss[idx],
                      ]
                    end
  end

  # ユーザにダウンロードさせるhtmlでコーディングされた文字列を返す
  def output_html
    strings = Array.new
    join_params.each do |params|
      img_tag = "<img src=\"#{params[1]}\"></img>"
      name_tag = "<span>#{params[2]}</span>"
      text_tag = ""
      channel_tag = ""
      strings.push(img_tag + name_tag + text_tag + channel_tag)
    end
    strings
  end

  # ユーザにダウンロードさせるmarkdown記法でコーディングされた文字列を返す
  def output_markdown
    string = Array.new
    string.push(Service::MarkdownMake.title("記事のタイトル")+ "\n"*2)
    join_params.each do |params|
      user_info = Service::MarkdownMake.user_info(params[2], params[1])
      text = Service::MarkdownMake.text(params[0])
      chat_info = Service::MarkdownMake.chat_info(params[3], params[5], params[4])
      string.push(user_info + "\n"*2 + text + "\n"*2 + chat_info + "\n"*2)
    end
    string
  end

  # 保存するチャットの総数
  def total_num
    texts.size
  end
end
