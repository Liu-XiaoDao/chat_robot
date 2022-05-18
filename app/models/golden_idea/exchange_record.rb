module GoldenIdea
  class ExchangeRecord < ApplicationRecord
    belongs_to :good
    belongs_to :employee
    before_create :set_status
    before_create :set_site

    def set_status
      self.status = "pending"
    end

    def good_name
      good.try :name
    end

    def employee_name
      employee.try :name
    end

    def self.to_xlsx(records)
      export_fields = ["good_name", "employee_name", "used_score", "quantity", "status"]
      SpreadsheetService.new.generate(export_fields, records)
    end

    def set_site
      self.site = Employee.current_employee.site
    end
  end
end
