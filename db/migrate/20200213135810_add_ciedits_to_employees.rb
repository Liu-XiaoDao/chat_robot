class AddCieditsToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :credits, :decimal, precision: 8, scale: 3
  end
end
