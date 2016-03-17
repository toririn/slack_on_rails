module SlackRails::Module::Base

  private

  def get_channel_list
    Channel.pluck(:name, :id)
  end

  def get_user_list
    User.pluck(:name, :id)
  end

  def get_user_image_list
    users = slack_client.users_list
    users["members"].map do |user|
      [user["name"], user["profile"]["image_24"]]
    end
  end

  def get_channels_info(channel_id)
    slack_client.channels_info(channel: channel_id)
  end

  def get_reactions_list(user_id)
    slack_client.reactions_list(user: user_id, count: Constants::SlackRails::CHECK_MAX_COUNT)
  end
end
