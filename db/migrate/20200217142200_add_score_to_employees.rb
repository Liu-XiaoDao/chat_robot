class AddScoreToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :score, :decimal, precision: 8, scale: 3
  end
end
