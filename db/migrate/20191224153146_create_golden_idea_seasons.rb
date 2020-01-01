class CreateGoldenIdeaSeasons < ActiveRecord::Migration[5.1]
  def change
    create_table :golden_idea_seasons do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
