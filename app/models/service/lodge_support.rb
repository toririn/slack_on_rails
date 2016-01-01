class Service::LodgeSupport <
  include Service::Base::LodgeSupport
  include ActiveModel::Model

  def output_file
    output = join_params
    output
  end

  #private

  def join_params
    texts.map.with_index do |text, idx|
      [
        text,
        images[idx],
        names[idx],
        channels[idx]
      ]
    end
  end

  def html_outputs
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

  def output_markdown
    
  end

  def total_num
    texts.size
  end
end
