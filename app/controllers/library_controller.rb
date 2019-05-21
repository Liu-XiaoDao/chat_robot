class LibraryController < ApplicationController
  layout 'library'
  def index
  end

  def borrow_books
    @books = Book.where(is_borrowed: 1).paginate page: params[:page], per_page: 10
  end

  def borrow_records
    @borrow_records = BorrowRecord.all.paginate page: params[:page], per_page: 10
  end

  def praise_rubbishs
    @praise_rubbishs = CountRecord.where(target_class: 'book').paginate page: params[:page], per_page: 10
  end

  def comments
    @comments = Comment.all.paginate page: params[:page], per_page: 10
  end

  def return_records
    @return_records = ReturnRecord.all.paginate page: params[:page], per_page: 10
  end

end
