module GoldenIdea
  class ExchangeRecord < ApplicationRecord
    belongs_to :good
    belongs_to :employee
    before_create :set_status

    def set_status
      self.status = "待兑换"
    end
  end
end
