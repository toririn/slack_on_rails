namespace :channels do
  desc "SlackのChannel一覧を取得してDBへ挿入する"
  task update: :environment do |task|
    Channel.delete_all
    channels = SLACK_OWNER.channels_list
    channel_list = channels["channels"].map do |channel|
                     [channel["name"], channel["id"], channel["purpose"]["value"]]
                   end.sort {|a, b| a[0] <=> b[0] }
    channel_list.each do |name, id, introduction|
      Channel.create(id: id, name: name, introduction: introduction)
    end
    puts "アップデート完了！"
  end
end
