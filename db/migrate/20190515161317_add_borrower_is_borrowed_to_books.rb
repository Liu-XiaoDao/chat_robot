class AddBorrowerIsBorrowedToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :is_borrowed, :integer
    add_column :books, :borrower_id, :integer
  end
end
