module TodoWorkHelper
  def time_by(sec)
    time = sec.slice(0, sec.index(".")).to_i
    date = Time.at(time)
    date.strftime("%Y年%m月%d日, %H時%M分%S秒")
  end

  def work_by(chat)
    chat.slice(chat.index("::")+2, chat.size) rescue ""
  end

  def doing_time(done_work, do_work_list)
    time = "Do未登録"
    done_text = work_by(done_work[:text])
    done_time = done_work[:ts].slice(0, done_work[:ts].index(".")).to_i
    do_work_list.each do |do_work|
      if work_by(do_work[:text]) == done_text
        do_time = do_work[:ts].slice(0, do_work[:ts].index(".")).to_i
        time = Time.at(done_time - do_time).utc.strftime("%X")
      end
    end
    time
  rescue => ex
    ""
  end
end
