class BookClassificationsController < ApplicationController
  def index
    @book_classifications = BookClassification.all
  end

  def new
    @book_classification = BookClassification.new
    render layout: false
  end

  def create
    # render json: params[:book_classification][:book_classification_name]
    @book_classification = BookClassification.create(book_classification_params)
    redirect_to book_classifications_path
  end

  def edit
    @book_classification = BookClassification.find(params[:id])
    render layout: false
  end

  def update
    @book_classification = BookClassification.find(params[:id])
    @book_classification.name = params[:book_classification][:name]
    @book_classification.save
    redirect_to book_classifications_path
  end

  private
    def book_classification_params
      params.require(:book_classification).permit(:name)
    end

end
