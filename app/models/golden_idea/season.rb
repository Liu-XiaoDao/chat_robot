module GoldenIdea
  class Season < ApplicationRecord
    after_create :transfer_pre_ideas
    has_many :ideas#, foreign_key: :golden_idea_season_id

    def transfer_pre_ideas
      pre_season = Season.pre_season
      ideas = pre_season.ideas.where(status: 'in progress')
      ideas.update_all(season_id: id)
    end

    def collecters
      collecter
    end

    def collecters=(str)
      return unless str.present?

      if str.is_a?(Array)
        str = str.reject(&:blank?).join(",")
      end

      self.collecter = str
    end

    def self.pre_season
      where(site: Employee.current_user.site).order(id: :desc).second
    end
  end
end
