module ApplicationHelper
  # 文字列中の改行文字を改行として出力させるメソッド
  # e.g. "hello\nworld" => "hello<br />world" 
  def br(text)
    text = h(text).gsub(/(\r\n?)|(\n)/, "<br />")
    text.html_safe
  end
end
