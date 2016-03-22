class AddLastAuthInUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_auth, :datetime
  end
end
