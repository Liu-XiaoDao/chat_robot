class AddIsInvolveSopToGoldenIdeaIdeas < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_ideas, :is_involve_sop, :integer
    add_column :golden_idea_ideas, :sop_file_path, :string
  end
end
