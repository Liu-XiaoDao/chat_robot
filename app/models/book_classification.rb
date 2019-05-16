class BookClassification < ApplicationRecord
  has_many :books

  def has_book?
    books.count > 1 ? true : false
  end
end
