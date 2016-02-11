module SlackRails::Module::Convert
  include SlackRails::Module::Base

  def convert_to_id(channel: nil, user: nil, team: nil)
    result = "missing"
    if channel
    channel_list = get_channel_list
    result = channel_list.find{ |ch| ch[0] == name }[1]
    elsif user
    elsif team
    end
    result
  rescue => ex
    "missing"
  end

  def convert_to_name(channel: nil, user: nil, team: nil)
    result = "missing"
    if channel
    elsif user
    elsif team
    end
  rescue => ex
    "missing"
  end

end
