class BorrowRecord < ApplicationRecord
  belongs_to :book
  belongs_to :employee

  validates :borrow_start, :borrow_end, :book_id, :employee_id, presence: true

  def update_real_borrow_time
    update(real_borrow_time: Integer(Date.today - borrow_start))
  end

  def update_real_borrow_time_and_note
    update(real_borrow_time: Integer(Date.today - borrow_start), note: "管理员回收")
  end

  def borrower_name
    employee.try :name
  end

  def book_name
    book.try :name
  end

  def borrow_length
    "#{borrow_range}个月"
  end

  def real_borrow_time
    # super || Integer(Date.today - borrow_start)
    if read_attribute(:real_borrow_time).present?
      "#{read_attribute(:real_borrow_time)}天"
    else
      "借阅中"
    end
  end
end
