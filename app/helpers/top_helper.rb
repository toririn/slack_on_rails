module TopHelper
  def hello(user_name)
    current_time = Time.now.to_i
    today_time = Time.zone.today.to_time.to_i
    hello = if current_time >= today_time + (18 * 60 * 60)
              "こんばんは"
            elsif current_time >= today_time + (12 * 60 * 60)
              "こんにちは"
            elsif current_time >= today_time + (6 * 60 * 60)
              "おはようございます。"
            else
              "ひゅ〜どろろろ"
            end
    "#{hello}、#{user_name}さん。"
  end
end
