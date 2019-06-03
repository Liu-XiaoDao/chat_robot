class AddYkCodeToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :yk_code, :string, limit: 20
  end
end
