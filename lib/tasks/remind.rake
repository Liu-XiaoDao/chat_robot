namespace :remind do
  desc "提醒还书"
  task(:return_book => :environment) do
    books = Book.where(is_borrowed: 1).each{ |book| book.return_remind }
  end
end
