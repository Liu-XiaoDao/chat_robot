class ChangeTypeOnCountRecords < ActiveRecord::Migration[5.1]
  def change
    change_table :count_records do |t|
      t.rename :type, :count_type
    end
  end
end
