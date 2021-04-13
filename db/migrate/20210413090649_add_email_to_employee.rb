class AddEmailToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :email, :string, limit: 50
  end
end
