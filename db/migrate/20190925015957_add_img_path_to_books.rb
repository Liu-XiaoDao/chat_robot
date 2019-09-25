class AddImgPathToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :img_path, :string
  end
end
