class Book < ApplicationRecord
  belongs_to :book_classification
  belongs_to :borrower, class_name: 'Employee', optional: true
  has_many :count_records, ->{ where( count_records: { target_class: "book" } ) }, :foreign_key => :target_id


  def classification_name
    book_classification.try :name
  end

  def status
    is_borrowed? ? "借阅中" : "未借阅"
  end
end
