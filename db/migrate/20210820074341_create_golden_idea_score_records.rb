class CreateGoldenIdeaScoreRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :golden_idea_score_records do |t|
      t.integer :employee_id
      t.integer :idea_id
      t.decimal :score, precision: 8, scale: 3
      t.timestamps
    end
  end
end
