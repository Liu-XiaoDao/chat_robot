class TempBookIsbn < ApplicationRecord
  validates :isbn, uniqueness: true
end
