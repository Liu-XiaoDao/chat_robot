class ChangeIsbnOnBooks < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :isbn, :string, limit: 20
  end
end
