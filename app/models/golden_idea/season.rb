module GoldenIdea
  class Season < ApplicationRecord
    after_create :transfer_pre_ideas
    has_many :ideas#, foreign_key: :golden_idea_season_id

    def transfer_pre_ideas
      pre_season = Season.pre_season
      ideas = pre_season.ideas.where(status: '进行中')
      ideas.update_all(season_id: id)
    end

    def self.pre_season
     order(id: :desc).second
    end
  end
end
