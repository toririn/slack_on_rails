class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.string :id
      t.string :name
      t.timestamps
    end
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
