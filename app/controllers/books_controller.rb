class BooksController < ApplicationController
  layout 'library'
  before_action :set_file_url, only: [:create, :update]
  def index
    @books = Book.all.paginate page: params[:page], per_page: 10
  end

  def index_admin
    # @q = Book.ransack(params[:q])
    # @books = @q.result(distinct: true).paginate page: params[:page], per_page: 8
    @books = Book.all.paginate page: params[:page], per_page: 8
  end

  def new
    @book = Book.new
    render layout: false
  end

  def create
    @book = Book.new
    # @book.update_attributes(book_params)
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
    @praise_record = @book.count_records.where(ip: request.remote_ip, count_type: "praise_count", employee_id: current_employee.id).first

    if @praise_record.blank?
      @count_record = @book.count_records.create(ip: request.remote_ip,count_type: "praise_count", employee_id: current_employee.id)#这种类型是点赞的记录
      @book.praise_count += 1
      @book.save
      render js: "$('#praise_count').html(#{@book.praise_count});"
    else
      render js: "alert('您已经点过赞了');"
    end
  end

  def rubbish
    @book = Book.find(params[:id])
    @praise_record = @book.count_records.where(ip: request.remote_ip,count_type: "rubbish_count", employee_id: current_employee.id).first
    if @praise_record.blank?
      @count_record = @book.count_records.create(ip: request.remote_ip,count_type: "rubbish_count", employee_id: current_employee.id)#这种类型是踩的记录
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
    @book = Book.find(params[:id])
    # TODO: 可以优化
    if @book.is_borrowed?
      flash["error"] = "有人正在借阅，您现在不能借阅"
    else
      if @book.borrow(params[:borrow][:borrower_time])
        flash["success"] = "借阅成功"
      end
    end
    redirect_to request.referer
  end

  def continue_borrow
    @book = Book.find(params[:id])
    if @book.continue_borrow
      flash["success"] = "续借成功"
    else
      flash["error"] = "续借失败"
    end
    redirect_to request.referer
  end

  def return_book
    @book = Book.find(params[:id])
    if @book.return_book
      flash["success"] = "还书成功"
    else
      flash["error"] = "还书失败"
    end
    redirect_to request.referer
  end

  def recycle_book
    @book = Book.find(params[:id])
    if @book.recycle_book
      flash["success"] = "收回成功"
    else
      flash["error"] = "收回失败"
    end
    redirect_to request.referer
  end

  def search
    @books = Book.search_name_by_token params[:term]
    @books_size = @books.size
    respond_to do |format|
      format.js { render :show }
    end
  end

  #批量上传
  def import
    if !params[:import][:file]
      redirect_to index_admin_books_path, alert: "You need select a file"
    else
      Book.import(params[:import][:file])
      redirect_to index_admin_books_path, notice: "导入成功"
    end
  end

  def export
    @books = Book.all
    respond_to { |format|
      format.html
      format.xlsx { send_data Book.to_xlsx(@books).stream.string, filename: "books.xlsx", disposition: 'attachment' }
    }
  end

  def all_comments
    @book = Book.find(params[:id])
    @comments = @book.comments
  end

  def scan_barcode
  end

  def scan_barcode_insert_isbn
    if params[:isbn].present?
      @temp_book_isbn = TempBookIsbn.new

      respond_to do |format|
        if @temp_book_isbn.update_attributes(isbn: params[:isbn])
          format.json { render json: {status: 1, msg: "扫描成功"} }
        else
          format.json { render json: {status: 0, msg: @temp_book_isbn.errors.full_messages[0]} }
        end
      end

    end
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
