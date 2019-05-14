class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string    :name
      t.string    :author
      t.text      :intro
      t.string    :img_url
      t.timestamps
    end
  end
end
