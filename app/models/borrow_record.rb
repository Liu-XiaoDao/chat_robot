class BorrowRecord < ApplicationRecord
  belongs_to :book
  belongs_to :employee

  def borrower_name
    employee.try :name
  end

  def book_name
    book.try :name
  end

  def borrow_length
    "#{borrow_range}个月"
  end
end
