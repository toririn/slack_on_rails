namespace :otacks do
  desc "各おたっくチャンネルごとの参加者一覧をDBへ挿入する"
  task update: :environment do |task|
    slack = SlackRails::Application.new(Constants::SLACK_API_TOKEN)
    otack_channels = Channel.otack_channels.pluck(:id, :name)
    otack_datas = []
    otack_channels.each do |id, name|
      member_ids = slack.channel_joined_member_ids(id)
      otack_datas << [id, name, member_ids.size, member_ids]
    end
    Otack.delete_all
    otack_datas.each do |id, name, members_num, member_ids|
      Otack.create(id: id, name: name, members_num: members_num, members: member_ids.join(","))
    end
    puts "アップデート完了！"
  end
end
