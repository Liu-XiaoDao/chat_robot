class CreateReturnRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :return_records do |t|
      t.integer  :book_id
      t.integer  :employee_id
      t.timestamps
    end
  end
end
