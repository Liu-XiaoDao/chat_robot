class AddRealBorrowTimeToBorrowRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :borrow_records, :real_borrow_time, :string
  end
end
