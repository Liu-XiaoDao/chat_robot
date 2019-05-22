class CountRecord < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :book, foreign_key: "target_id", optional: true
  belongs_to :question, foreign_key: "target_id", optional: true

  def book_name
    book.try(:name)
  end

  def type
    count_type == "praise_count" ? "赞" : "垃圾"
  end

  def operation_time
    created_at.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end

  def employee_name
    employee.try :name
  end
end
