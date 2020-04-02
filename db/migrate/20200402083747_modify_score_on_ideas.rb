class ModifyScoreOnIdeas < ActiveRecord::Migration[5.1]
  def change
    change_column :golden_idea_ideas, :score, :Integer
  end
end
