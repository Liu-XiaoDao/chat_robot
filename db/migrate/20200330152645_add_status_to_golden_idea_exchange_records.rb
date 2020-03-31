class AddStatusToGoldenIdeaExchangeRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_exchange_records, :status, :string
  end
end
