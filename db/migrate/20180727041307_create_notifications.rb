class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string   :target_class
      t.integer  :target_id
      t.string   :content
      t.timestamps
    end
  end
end
