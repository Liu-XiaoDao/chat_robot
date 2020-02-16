module GoldenIdea
  class Idea < ApplicationRecord
    belongs_to :seasion, optional: true

    scope :top_5, ->{order(praise_count: :desc)}

    before_create :set_seasion

    #def proposer=(str)
    #  binding.pry
    #end

    def proposers
      proposer
    end

    def proposers=(str)
      return unless str.present?

      if str.is_a?(Array)
        str = str.reject(&:blank?).join(",")
      end

      self.proposer = str
    end

    def set_seasion
      self.season_id = Season.last.id
    end
  end
end
