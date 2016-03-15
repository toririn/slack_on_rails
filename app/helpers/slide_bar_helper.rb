module SlideBarHelper

  def kb_in(channel_list)
    channel_list.map do |channel|
      if channel[0] =~ /\Akb/
        [channel[0], channel[0]]
      end
    end.compact.unshift(["ナレッジ系", ""]) rescue []
  end

  def times_in(channel_list)
    channel_list.map do |channel|
      if channel[0] =~ /\Atimes/
        [channel[0], channel[0]]
      end
    end.compact.unshift(["分報系", ""]) rescue []
  end

  def xclub_in(channel_list)
    channel_list.map do |channel|
      if channel[0] =~ /\Axclub/
        [channel[0], channel[0]]
      end
    end.compact.unshift(["部活動系", ""]) rescue []
  end

  def etc_in(channel_list)
    channel_list.map do |channel|
      unless channel[0] =~ /\A(kb)|(times)|(xclub)/
        [channel[0], channel[0]]
      end
    end.compact.unshift(["その他", ""]) rescue []
  end
end
