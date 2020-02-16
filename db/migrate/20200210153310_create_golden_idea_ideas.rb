class CreateGoldenIdeaIdeas < ActiveRecord::Migration[5.1]
  def change
    create_table :golden_idea_ideas do |t|
      t.string :title
      t.string :description
      t.string :department
      t.string :category
      t.string :status
      t.text   :content
      t.string :proposer
      t.references :golden_idea_season
      t.timestamps
    end
  end
end
