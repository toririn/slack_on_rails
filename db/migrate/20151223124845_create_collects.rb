class CreateCollects < ActiveRecord::Migration
  def change
    create_table :collects do |t|
      t.string :name
      t.string :text

      t.timestamps null: false
    end
  end
end
