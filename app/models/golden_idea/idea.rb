module GoldenIdea
  class Idea < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    belongs_to :season, optional: true
    belongs_to :reporter, class_name: "Employee", optional: true
    has_many :assign_score_records

    scope :top_5, ->{order(score: :desc)}

    before_create :set_seasion
    before_create :set_reporter
    after_update :assign_score, if: :score_changed?

    validates :title, :category, :proposers, :department, presence: true
    validates :title, uniqueness: true
    validates :description, length: { maximum: 230  }

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

    def reporter_name
      reporter.try :name
    end

    def reporter_name=(str)
      return if str.blank?

      self.reporter = Employee.find_by_name(str)
    end

    def proposer_names
      proposer.split(",").map{|u_id| Employee.find(u_id).name }.join(",")
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
      self.origin_season_id = season_id
    end

    def set_reporter
      self.reporter_id = Employee.current_employee.id if reporter_id.blank?
    end

    def assign_score
      return if proposers.blank?
      return if score.blank?
      return if assign_score_records.present?


      proposer_ids = proposers.split(",")

      average_score = (score/proposer_ids.count).round(1)
      proposer_ids.each do |p_id|
        if Employee.find(p_id).assign_score(average_score)
          AssignScoreRecord.create(employee_id: p_id, idea_id: self.id, score: average_score)
        end
      end
    end

    # 导入文件
    # def self.import(file)
      # spreadsheet = SpreadsheetService.new.parse(file)
      # headers = spreadsheet.row(1)
      # (2..spreadsheet.last_row).each do |i|
        # row = Hash[[headers, spreadsheet.row(i).map(&:to_s)].transpose]

        # idea = find_by_title(row['title'])
        # idea ||= new
        # idea.attributes = row.to_hash.slice(*["title", "description", "department", "category", "proposer_names", "season_name", "score"])
        # idea.save
      # end
    # end

    def self.import_preview(file)
      create_record = []

      spreadsheet = SpreadsheetService.new.parse(file)
      headers = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[headers, spreadsheet.row(i).map(&:to_s)].transpose]
        idea = find_by_title(row['title'])
        idea ||= new
        idea.attributes = row.to_hash.slice(*["title", "description", "department", "status", "category", "proposer_names", "season_name", "score"])
        create_record << idea
      end
      create_record
    end

    def self.to_xlsx(records)
      export_fields = ["title", "description", "department", "status", "category", "reporter_name", "proposer_names", "season_name", "score"]
      SpreadsheetService.new.generate(export_fields, records)
    end

    class << self
      # 根据关键字搜索金点子
      # 最多返回100条记录
      #只搜索name
      def search_name_by_token(token)
        opts = {
          size: 100,
          query: {
            bool: {
              must: [
                { multi_match:
                  {
                    query: token.to_s,
                    fields: ['title']
                  }
                }
              ]
            }
          },
          highlight: {
            pre_tags: ["<strong>"],
            post_tags: ["</strong>"],
            number_of_fragments: 1,
            fragment_size: 100,
            fields: {
              title: { fragment_size: 20, number_of_fragments: 1 },
              content: {}
            }
          }
        }
        Elasticsearch::Model.search(opts).records
      end

    end
  end
end
