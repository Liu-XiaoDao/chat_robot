class AddOriginSeasonIdToGoldenIdeaIdeas < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_ideas, :origin_season_id, :integer
  end
end
