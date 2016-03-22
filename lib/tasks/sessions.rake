namespace :sessions do
  desc "SlackのUser一覧を取得してDBへ挿入する"
  task clear: :environment do |task|
    Session.old.delete_all
    puts "Sessions クリア完了！"
  end
end
