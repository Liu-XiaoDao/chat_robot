class DefaultValueEmployees < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:employees, :score, 0)
    change_column_default(:employees, :available_score, 0)
  end
end
