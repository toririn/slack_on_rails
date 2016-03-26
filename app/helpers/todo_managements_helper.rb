module TodoManagementsHelper
  def time_by(sec)
    time = sec.slice(0, sec.index(".")).to_i
    date = Time.zone.at(time)
    date.strftime("%Y年%m月%d日, %H時%M分%S秒")
  end

  def work_by(chat)
    chat.slice(chat.index("::")+2, chat.size) rescue ""
  end

  def convert_date(date)
    return Time.zone.now.strftime("%Y年%m月%d日") if date.blank?
    fetch_date = /\A(\d*)\/(\d*)\/(\d*)/
    date =~ fetch_date
    "#{$3}年#{$1}月#{$2}日"
  rescue => ex
    puts ex, ex.backtrace
    Time.zone.now.strftime("%Y年%m月%d日")
  end

  def doing_time(done_work, do_work_list, done_work_list, index_no)
    done_text = work_by(done_work[:text])
    done_time = done_work[:ts].slice(0, done_work[:ts].index(".")).to_i
    from_do_time(done_text, done_time, do_work_list) || from_done_time(done_time, done_work_list, index_no)
  rescue => ex
    puts ex, ex.backtrace
    "エラー"
  end

  def from_do_time(done_text, done_time, do_work_list)
    time = false
    do_work_list.each do |do_work|
      if work_by(do_work[:text]) == done_text
        do_time = do_work[:ts].slice(0, do_work[:ts].index(".")).to_i
        time = Time.zone.at(done_time - do_time).utc.strftime("%X")
      end
    end
    time
  end

  def from_done_time(done_time, done_work_list, index_no)
    idx = index_no - 1
    if (idx == 0)
      selected_day = @selected_day_time || Time.zone.today
      beginning_time = selected_day.since(9.hours).to_i
      if (done_time >= beginning_time)
        Time.zone.at(done_time - beginning_time).utc.strftime("%X")
      else
        Time.zone.at(beginning_time - done_time).utc.strftime("%X")
      end
    else
      before_done = done_work_list[idx-1][:ts]
      before_done_time = before_done.slice(0, before_done.index(".")).to_i
      Time.zone.at(done_time - before_done_time).utc.strftime("%X")
    end
  end
end
