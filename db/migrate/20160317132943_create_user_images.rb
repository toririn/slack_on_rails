class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images, id: false do |t|
      t.string  :id
      t.string  :path
      t.timestamps
    end
    execute "ALTER TABLE user_images ADD PRIMARY KEY (id);"
  end
end
