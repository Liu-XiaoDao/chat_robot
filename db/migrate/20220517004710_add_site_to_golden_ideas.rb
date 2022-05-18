class AddSiteToGoldenIdeas < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_assign_score_records, :site, :string, limit:50
    add_column :golden_idea_exchange_records, :site, :string, limit:50
    add_column :golden_idea_goods, :site, :string, limit:50
    add_column :golden_idea_ideas, :site, :string, limit:50
    add_column :golden_idea_score_records, :site, :string, limit:50
    add_column :golden_idea_seasons, :site, :string, limit:50
    add_column :golden_idea_suggests, :site, :string, limit:50
  end
end
