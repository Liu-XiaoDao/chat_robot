class CategorysController < ApplicationController
  def index
    @categorys = Category.all
  end

  def new
  	@category = Category.new
  	render layout: false
  end

  def create
  	# render json: params[:category][:category_name]
    @category = Category.create(category_params)
    redirect_to categorys_path
  end

  def edit
  	@category = Category.find(params[:id])
  	render layout: false
  end

  def update
  	@category = Category.find(params[:id])
  	@category.category_name = params[:category][:category_name]
  	@category.save
    redirect_to categorys_path
  end

  private
    def category_params
      params.require(:category).permit(:category_name)
    end
end