class AddBenefitCostRiskToGoldenIdeaScoreRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_score_records, :benefit, :decimal, :precision => 8, :scale => 3
    add_column :golden_idea_score_records, :cost, :decimal, :precision => 8, :scale => 3
    add_column :golden_idea_score_records, :risk, :decimal, :precision => 8, :scale => 3
  end
end
