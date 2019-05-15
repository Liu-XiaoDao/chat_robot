class ModifyQuestionIdOnCountRecords < ActiveRecord::Migration[5.1]
  def change
    add_column    :count_records, :target_class, :string
    rename_column :count_records, :question_id,  :target_id
    add_column    :count_records, :employee_id,  :integer
  end
end
