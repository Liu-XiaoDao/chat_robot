class CreateGoldenIdeaGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :golden_idea_goods do |t|
      t.string "name"
      t.string  "description"
      t.string  "avatar"
      t.integer "quantity"
      t.text    "content"
      t.timestamps
    end
  end
end
