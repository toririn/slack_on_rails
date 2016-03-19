class Outputs::TodoManagementsReport
  include ActiveModel::Model

  attr_accessor(
    :todo_list,
    :done_work_list,
    :done_time_list,
    :user_name,
    :report_date,
  )

  # ユーザにダウンロードさせる文字列（ファイル）を返すメソッド
  def output_data(type = nil)
    if type == "html"
      output
    else
      output.join(String::LF)
    end
  end

  private

  def output
    strings = []
    strings << "●作業報告概要"
    strings << "  日時：#{report_date}"
    strings << "  報告者：#{user_name}"
    strings << "  稼働時間：#{work_time}"
    strings << ""
    strings  << "●今日のTODO一覧"
    todo_list.each {|todo| strings << "  ・#{todo}" } rescue ""
    strings << ""
    strings << "●今日の実績(作業時間)"
    done_work_list.zip(done_time_list) {|work, time| strings << "  ・#{work}(#{time})" } rescue ""
    strings
  end

  def work_time
    sum_hour, sum_minute, sum_second = 0, 0, 0
    done_time_list.each do |time|
      hour, minute, second = time.split(":")
      sum_hour += hour.to_i
      sum_minute += minute.to_i
      sum_second = second.to_i
    end
    sum_minute += (sum_second / 60) + 1
    sum_hour += (sum_minute / 60) + 1
    "#{sum_hour}時間#{sum_minute % 60}分"
  rescue => ex
    puts ex, ex.backtrace
    "不明"
  end
end
