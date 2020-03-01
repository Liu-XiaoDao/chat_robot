class RenameSeasonIdOnGoldenIdeaIdeas < ActiveRecord::Migration[5.1]
  def change
    rename_column :golden_idea_ideas, :golden_idea_season_id, :season_id
  end
end
