module GoldenIdea
  class ExchangeRecord < ApplicationRecord
    belongs_to :good
    belongs_to :employee
  end
end
