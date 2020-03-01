class AddScoreToGoldenIdeaIdeas < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_ideas, :score, :decimal, precision: 8, scale: 3
  end
end
