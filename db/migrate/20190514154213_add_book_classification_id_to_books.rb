class AddBookClassificationIdToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :book_classification_id, :integer
  end
end
