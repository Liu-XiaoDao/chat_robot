class BooksController < ApplicationController
  layout 'library'
  def index
    @books = Book.all
  end

  def index_admin
    @books = Book.all
  end

  def new
    @book = Book.new
    render layout: false
  end
end
