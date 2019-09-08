class AddHiredDateToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :hired_date, :date
  end
end
