class Book < ApplicationRecord
  belongs_to :book_classification
  belongs_to :borrower, class_name: 'Employee', optional: true
  has_many :count_records, ->{ where( count_records: { target_class: "book" } ) }, :foreign_key => :target_id
  has_many :borrow_records

  def classification_name
    book_classification.try :name
  end

  def borrow(borrow_time)
    borrow_records.create(employee_id: 1, borrow_range: borrow_time, borrow_start: Date.today, borrow_end: Date.today + 3.month) && self.update(is_borrowed: 1)
  end

  def status
    is_borrowed? ? "借阅中" : "未借阅"
  end
end
