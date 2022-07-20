module GoldenIdea
  class AssignScoreRecord < ApplicationRecord
    belongs_to :idea, optional: true
    belongs_to :employee
    before_create :set_site

    def set_site
      self.site = Employee.current_employee.site
    end
  end
end
