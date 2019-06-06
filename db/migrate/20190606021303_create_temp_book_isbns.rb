class CreateTempBookIsbns < ActiveRecord::Migration[5.1]
  def change
    create_table :temp_book_isbns do |t|
      t.string   :isbn
      t.timestamps
    end
  end
end
