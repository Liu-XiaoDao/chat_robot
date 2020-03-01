module GoldenIdea
  class AssignScoreRecord < ApplicationRecord
    belongs_to :idea
    belongs_to :employee
  end
end
