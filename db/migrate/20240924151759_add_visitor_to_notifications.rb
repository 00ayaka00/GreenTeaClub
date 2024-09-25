class AddVisitorToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :visitor_id, :integer
  end
end
