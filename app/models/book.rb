class Book < ApplicationRecord
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
end
