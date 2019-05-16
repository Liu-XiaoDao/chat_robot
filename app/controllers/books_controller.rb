class BooksController < ApplicationController
  layout 'library'
  before_action :set_file_url, only: [:create, :update]
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

  def create
    @book = Book.new
    @book.update_attributes(book_params)
    if @book.update_attributes(book_params)
      flash["success"] = "添加成功"
    else
      flash["error"] = "添加错误:#{@book.errors.full_messages}"
    end
    redirect_to index_admin_books_path
  end

  def edit
    @book = Book.find(params[:id])
    render layout: false
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash["success"] = "编辑成功"
    else
      flash["error"] = "编辑错误:#{@book.errors.full_messages}"
    end
    redirect_to index_admin_books_path
  end

  def show
    @book = Book.find(params[:id])
  end

  def praise
    @book = Book.find(params[:id])
    @praise_record = @book.count_records.where(ip: request.remote_ip, count_type: "praise_count").first

    if @praise_record.blank?
      @count_record = @book.count_records.create(ip: request.remote_ip,count_type: "praise_count")#这种类型是点赞的记录
      @book.praise_count += 1
      @book.save
      render js: "$('#praise_count').html(#{@book.praise_count});"
    else
      render js: "alert('您已经点过赞了');"
    end
  end

  def rubbish
    @book = Book.find(params[:id])
    @praise_record = @book.count_records.where(ip: request.remote_ip,count_type: "rubbish_count").first
    if @praise_record.blank?
      @count_record = @book.count_records.create(ip: request.remote_ip,count_type: "rubbish_count")#这种类型是踩的记录
      @book.rubbish_count += 1
      @book.save
      render js: "$('#rubbish_count').html(#{@book.praise_count});"
    else
      render js: "alert('您已经踩过了');"
    end
  end

  def borrow_view
    @book = Book.find(params[:id])
    render layout: false
  end

  def borrow
    flash["success"] = "借阅成功"
    redirect_to book_path
  end

  private
    def book_params
      params.require(:book).permit(:name, :author, :book_classification_id, :intro, :img_url)
    end

    def set_file_url
      return if params[:book][:file].blank?

      @file_url = UploadFileService.save_file(params[:book][:file])
      params[:book][:img_url] = @file_url
    end
end
