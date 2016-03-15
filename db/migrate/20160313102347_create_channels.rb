class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels, id: false do |t|
      t.string :id
      t.string :name
      t.timestamps
    end
    execute "ALTER TABLE channels ADD PRIMARY KEY (id);"
  end
end
