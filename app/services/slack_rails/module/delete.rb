module SlackRails::Module::Delete
  include SlackRails::Module::Base

  def delete_by_chat_in_channel(ts: , channel_id:)
    result = slack_client.chat_delete(ts: ts, channel: channel_id)
    result["ok"]
  end

end
