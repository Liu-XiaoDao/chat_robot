class CreateBookClassifications < ActiveRecord::Migration[5.1]
  def change
    create_table :book_classifications do |t|
      t.string   :name
      t.string   :intro
      t.timestamps
    end
  end
end
