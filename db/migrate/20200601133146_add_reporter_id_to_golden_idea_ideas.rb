class AddReporterIdToGoldenIdeaIdeas < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_ideas, :reporter_id, :integer
  end
end
