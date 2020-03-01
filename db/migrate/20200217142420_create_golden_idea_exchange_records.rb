class CreateGoldenIdeaExchangeRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :golden_idea_exchange_records do |t|
      t.references :good
      t.references :employee
      t.decimal    :used_score, precision: 8, scale: 3
      t.integer    :quantity
      t.timestamps
    end
  end
end
