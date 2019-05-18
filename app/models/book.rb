class Book < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :book_classification
  belongs_to :borrower, class_name: 'Employee', optional: true
  has_many :count_records, ->{ where( count_records: { target_class: "book" } ) }, :foreign_key => :target_id
  has_many :borrow_records
  has_many :return_records
  has_many :comments

  def classification_name
    book_classification.try :name
  end

  def borrow(borrow_time)
    borrow_records.create(employee_id: Employee.current_employee.id, borrow_range: borrow_time, borrow_start: Date.today, borrow_end: Date.today + 3.month) && self.update(is_borrowed: 1, borrower_id: Employee.current_employee.id)
  end

  def return_book
    self.update(is_borrowed: 0, borrower_id: nil) && \
    return_records.create(employee_id: Employee.current_employee.id) && \
    borrow_records.last.update_real_borrow_time
  end

  def borrower_name
    borrower.try(:name)
  end

  def status
    is_borrowed? ? "借阅中" : "未借阅"
  end


  class << self
    # 根据关键字搜索图书
    # 最多返回100条记录
    # user限制搜索范围
    def search_by_token(token, category_id = nil)
      opts = {
        size: 100,
        query: {
          bool: {
            must: [
              { multi_match:
                {
                  query: token.to_s,
                  fields: ['title', 'content']
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
              title: { number_of_fragments: 0 },
              content: {}
          }
        }
      }
      opts[:query][:bool][:must].push({ match: { category_id: category_id } }) unless category_id.blank?
      search(opts).records
    end
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
                  fields: ['name']
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
              name: { number_of_fragments: 0 },
              content: {}
          }
        }
      }
      search(opts).records
    end
  end

end
