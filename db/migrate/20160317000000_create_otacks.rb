class CreateOtacks < ActiveRecord::Migration
  def change
    create_table :otacks, id: false do |t|
      t.string  :id
      t.string  :name
      t.integer :members_num
      t.text    :members
      t.timestamps
    end
    execute "ALTER TABLE otacks ADD PRIMARY KEY (id);"
  end
end
