module SlackRails::Module::Read
  include SlackRails::Module::Base

  def channel_list
    channel_list = get_channel_list
    channel_list.sort {|a, b| a[0] <=> b[0] }
  rescue => ex
    []
  end

  def user_list
    user_list = get_user_list
    user_list || []
  rescue => ex
    []
  end

  def user_image_list
    user_image_list = get_user_image_list.to_h
    user_image_list || []
  rescue => ex
    []
  end

end
