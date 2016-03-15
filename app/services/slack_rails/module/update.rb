module SlackRails::Module::Update
  include SlackRails::Module::Base

  def update_by_chat_in_channel(ts: , channel_id: , text: )
    result = slack_client.chat_update(ts: ts, channel: channel_id, text: text)
    result["ok"]
  end

end
