module SlackRails::Module:Post:
  include SlackRails::Module::Base

  def post_by_chat_in_channel(username: , channel_id: , text: )
    result = slack_client.chat_update(ts: ts, channel: channel_id, text: text)
    result["ok"]
  end

end
