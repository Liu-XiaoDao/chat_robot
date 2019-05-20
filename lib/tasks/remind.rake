namespace :remind do
  desc "提醒还书"
  task(:return_book => :environment) do
    BorrowRecord.where(borrow_end: Date.today..(Date.today + 7.days))
    binding.pry
  end
end
