class AddNoteToBorrowRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :borrow_records, :note, :string
  end
end
