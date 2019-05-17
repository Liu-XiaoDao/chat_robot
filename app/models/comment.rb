class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :employee
  after_initialize :set_employee

  default_scope { order(id: :desc) }

  # before_create :set_employee

  def set_employee
    self.employee = Employee.current_employee
  end

  def employee_avatar
    employee.try(:avatar)
  end

  def employee_name
    employee.try(:name)
  end

  def comment_time
    created_at.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end

  def book_name
    book.try(:name)
  end

  def book_classification
    book.try(:classification_name)
  end
end
