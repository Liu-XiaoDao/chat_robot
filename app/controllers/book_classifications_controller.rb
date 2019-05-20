class BookClassificationsController < ApplicationController
  layout 'library'

  def index
    @book_classifications = BookClassification.all
  end

  def index_admin
    @book_classifications = BookClassification.all
  end

  def new
    @book_classification = BookClassification.new
    render layout: false
  end

  def create
    # render json: params[:book_classification][:book_classification_name]
    @book_classification = BookClassification.create(book_classification_params)
    redirect_to index_admin_book_classifications_path
  end

  def edit
    @book_classification = BookClassification.find(params[:id])
    render layout: false
  end

  def update
    @book_classification = BookClassification.find(params[:id])
    @book_classification.name = params[:book_classification][:name]
    @book_classification.save
    redirect_to index_admin_book_classifications_path
  end

  def show
    @book_classification = BookClassification.find(params[:id])
    @classification_books = @book_classification.books.paginate page: params[:page], per_page: 10
  end

  def show_admin
    @book_classification = BookClassification.find(params[:id])
    @classification_books = @book_classification.books.paginate page: params[:page], per_page: 8
  end

  def destroy
    @book_classification = BookClassification.find(params[:id])
    if @book_classification.has_book?
      flash["error"] = "分类下有图书禁止删除"
    else
      if @book_classification.destroy
        flash["success"] = "分类:#{@book_classification.name} 删除成功"
      else
        flash["error"] = "删除失败"
      end
    end
    redirect_to book_classifications_path
  end
  private
    def book_classification_params
      params.require(:book_classification).permit(:name)
    end

end
