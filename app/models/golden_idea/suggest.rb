module GoldenIdea
  class Suggest < ApplicationRecord
    belongs_to :employee, optional: true
    belongs_to :suggest, optional: true
    has_many :replys, class_name: "Suggest", foreign_key: "suggest_id"

    before_create :set_employee


    def employee_name
      employee.try :name
    end

    def set_employee
      self.employee_id = Employee.current_employee.id
    end
  end
end
