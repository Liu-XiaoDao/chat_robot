module GoldenIdea
  class Season < ApplicationRecord
    has_many :ideas#, foreign_key: :golden_idea_season_id
  end
end
