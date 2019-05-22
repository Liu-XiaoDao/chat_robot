class ReturnRecord < ApplicationRecord
  belongs_to :book
  belongs_to :employee

  def book_name
    book.try :name
  end

  def borrower_name
    employee.try :name
  end

  def return_time
    created_at.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
end
