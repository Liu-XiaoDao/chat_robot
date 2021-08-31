class ChangeScoreOnGoldenIdeaIdeas < ActiveRecord::Migration[5.1]
  def change
    change_column :golden_idea_ideas, :score, :decimal, precision: 8, scale: 1
  end
end
