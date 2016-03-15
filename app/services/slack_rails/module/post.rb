module SlackRails::Module::Post
  include SlackRails::Module::Base

  def post_by_chat_in_channel(username: , channel_id: , text: )
    result = slack_client.chat_postMessage(username: username, channel: channel_id, text: text)
    result["ok"]
  end

end
