class AddIsLeaveToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :is_leave,  :integer, limit: 1, default: 0, comment: "记录员工是否离职,已离职:1,未离职:0"
  end
end
