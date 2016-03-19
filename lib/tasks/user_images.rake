namespace :user_images do
  desc "Slackのユーザ画像一覧を取得してDBへ挿入する"
  task update: :environment do |task|
    users = SLACK_OWNER.users_list
    image_list = users["members"].map do |user|
                   [user["id"], user["profile"]["image_24"]]
                 end
    if image_list.present?
      UserImage.delete_all
      image_list.each do |id, image_path|
        UserImage.create(id: id, path: image_path)
      end
      puts "User Images アップデート完了！"
    else
      puts "User Images アップデート失敗！"
    end
  end
end
