class AddEmployeeIdToUserRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :user_requests, :employee_id, :integer
  end
end
