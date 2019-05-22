class AddNoteToReturnRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :return_records, :note, :string
  end
end
