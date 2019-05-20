class ChangeTargetClassOnNotifications < ActiveRecord::Migration[5.1]
  def change
    rename_column :notifications, :target_class,  :target_type
  end
end
