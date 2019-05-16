class CreateBorrowRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :borrow_records do |t|
      t.integer  :book_id
      t.integer  :employee_id
      t.date     :borrow_start
      t.date     :borrow_end
      t.string   :borrow_range
      t.timestamps
    end
  end
end
