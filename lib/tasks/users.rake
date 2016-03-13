namespace :users do
  desc "SlackのUser一覧を取得してDBへ挿入する"
  task update: :environment do |task|
    User.delete_all
    users = SLACK_OWNER.users_list
    user_list = users["members"].map do |user|
                  [user["name"], user["id"]]
                end.sort {|a, b| a[0] <=> b[0] }
    user_list.each do |name, id|
      User.create(id: id, name: name)
    end
    puts "アップデート完了！"
  end
end
