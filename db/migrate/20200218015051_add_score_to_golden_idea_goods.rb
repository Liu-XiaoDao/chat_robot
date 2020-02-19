class AddScoreToGoldenIdeaGoods < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_goods, :score, :integer
  end
end
