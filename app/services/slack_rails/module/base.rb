module SlackRails::Module::Base

  private

  def get_channel_list
    SLACK_CHANNEL_LIST
  end

  def get_user_list
    SLACK_USER_LIST
  end

  def get_user_image_list
    users = slack_client.users_list
    users["members"].map do |user|
      [user["name"], user["profile"]["image_24"]]
    end
  end

  def get_reactions_list(user_id)
    slack_client.reactions_list(user: user_id, count: 20)
  end
end
