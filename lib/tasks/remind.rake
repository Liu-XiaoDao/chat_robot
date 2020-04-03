namespace :remind do
  desc "提醒还书"
  task(:return_book => :environment) do
    books = Book.where(is_borrowed: 1).each{ |book| book.return_remind }
  end

  desc "分配历史积分"
  task(:assign_history_score => :environment) do
    GoldenIdea::Idea.all.each do |i|
      puts i.title
      i.save
    end
  end
end
