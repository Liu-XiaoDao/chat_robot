module GoldenIdea
  class ScoreRecord < ApplicationRecord
    belongs_to :idea
    belongs_to :employee, optional: true

    before_create :set_employee
    before_save :update_score
    before_create :set_site

    validates :benefit, :cost, :risk, presence: true


    def set_employee
      self.employee_id = Employee.current_employee.id
    end

    def update_score
      self.score = (benefit * 0.5) + (cost * 0.3) + (risk * 0.2)
    end

    def set_site
      self.site = Employee.current_employee.site
    end
  end
end
