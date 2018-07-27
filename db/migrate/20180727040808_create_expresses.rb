class CreateExpresses < ActiveRecord::Migration[5.1]
  def change
    create_table :expresses do |t|
      t.integer :employee_id
      t.string  :express_type
      t.boolean :is_send_noti
      t.timestamps
    end
  end
end
