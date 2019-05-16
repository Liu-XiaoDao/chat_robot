class BorrowRecord < ApplicationRecord
  belongs_to :book
  belongs_to :employee
end
