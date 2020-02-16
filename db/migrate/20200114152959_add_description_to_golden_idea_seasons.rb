class AddDescriptionToGoldenIdeaSeasons < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_seasons, :description, :string
  end
end
