class ChangeDefaultOnQuestions < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:questions, :view_count, 0)
    change_column_default(:questions, :praise_count, 0)
    change_column_default(:questions, :rubbish_count, 0)
    change_column_default(:questions, :is_check, 0)
  end
end
