class AddColumnToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :introduction, :text
  end
end
