class Department < ApplicationRecord
  has_many :employees
  has_one :manager, ->{ where( employees: { isleader: true } ) }, class_name: "Employee"

  def manager_name
    manager.try :name
  end
end
