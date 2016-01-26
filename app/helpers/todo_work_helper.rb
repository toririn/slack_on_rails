module TodoWorkHelper
  def time_by(sec)
    time = sec.slice(0, sec.index(".")).to_i
    date = Time.at(time)
    date.strftime("%Y年%m月%d日, %H時%M分%S秒")
  end

  def work_by(chat)
    chat.slice(chat.index("::")+2, chat.size)
  end

  def doing_time(done_work, do_work_list)
    time = "Do未登録"
    done_text = work_by(done_work[0]) 
    done_time = done_work[1].slice(0, done_work[1].index(".")).to_i
    do_work_list.each do |do_work|
      if work_by(do_work[0]) == done_text
        do_time = do_work[1].slice(0, do_work[1].index(".")).to_i
        time = Time.at(done_time - do_time).utc.strftime("%X")
      end
    end
    time
  end
end
