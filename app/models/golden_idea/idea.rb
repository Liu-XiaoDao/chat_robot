module GoldenIdea
  class Idea < ApplicationRecord
    belongs_to :seasion, optional: true

    scope :top_5, ->{order(score: :desc)}

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

    def is_edit?(employee_id)
      return false if proposer.blank? || employee_id.blank?

      proposer.split(",").include?(employee_id.to_s)
    end

    def is_complate?
      score.present? ? true : false
    end

    def set_seasion
      self.season_id = Season.last.id
    end
  end
end
