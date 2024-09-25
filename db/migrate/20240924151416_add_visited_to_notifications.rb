class AddVisitedToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :visited_id, :integer
  end
end
