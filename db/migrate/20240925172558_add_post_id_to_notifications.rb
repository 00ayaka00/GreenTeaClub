class AddPostIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :post_id, :integer
    add_index :notifications, :post_id
  end
end
