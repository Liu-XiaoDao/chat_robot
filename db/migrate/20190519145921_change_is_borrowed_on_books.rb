class ChangeIsBorrowedOnBooks < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :is_borrowed, :integer, default: 0
  end
end
