class AddInfoToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :info, :string
  end
end
