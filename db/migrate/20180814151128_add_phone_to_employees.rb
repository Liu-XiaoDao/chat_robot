class AddPhoneToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :extension_number, :string
    add_column :employees, :linear_telephone, :string
  end
end
