module GoldenIdea
  class Idea < ApplicationRecord
    belongs_to :season, optional: true
    has_many :assign_score_records

    scope :top_5, ->{order(score: :desc)}

    before_create :set_seasion
    after_create :assign_score

    validates :title, :category, :proposers, :department, presence: true

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

    def proposer_names=(str)
      return unless str.present?

      employee_names = str.split(",")
      employee_ids = employee_names.map{|name| Employee.find_by_name(name).id}

      self.proposer = employee_ids.join(",") if employee_ids.present?
    end

    def season_name
      season.name
    end

    def season_name=(str)
      return if str.blank?

      self.season = Season.find_by_name(str)
    end

    def is_edit?(employee_id)
      return false if proposer.blank? || employee_id.blank?

      proposer.split(",").include?(employee_id.to_s)
    end

    def is_complate?
      score.present? ? true : false
    end

    def set_seasion
      self.season_id = Season.last.id if season_id.blank?
    end

    def assign_score
      return if proposers.blank?
      return if score.blank?

      proposer_ids = proposers.split(",")

      average_score = (score/proposer_ids.count).round(1)
      proposer_ids.each do |p_id|
        if Employee.find(p_id).assign_score(average_score)
          AssignScoreRecord.create(employee_id: p_id, idea_id: self.id, score: average_score)
        end
      end
    end

    # 导入文件
    def self.import(file)
      spreadsheet = SpreadsheetService.new.parse(file)
      headers = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[headers, spreadsheet.row(i).map(&:to_s)].transpose]
        idea = new
        idea.attributes = row.to_hash.slice(*["title", "description", "department", "category", "proposer_names", "season_name", "score"])
        idea.save
      end
    end

  end
end
