class LinksController < ApplicationController

  def index
    @links = Link.all
  end

  def display_list
    @links = Link.all
  end

  def new
  	@link = Link.new
  	render layout: false
  end

  def create
  	# render json: params[:category][:category_name]
    @link = Link.create(category_params)
    redirect_to links_path
  end

  def edit
  	@link = Link.find(params[:id])
  	render layout: false
  end

  def update
  	@link = Link.find(params[:id])
    @link.title = params[:link][:title]
    @link.url_link = params[:link][:url_link]
  	@link.icon = params[:link][:icon]

  	@link.save
    redirect_to links_path
  end

  private
    def category_params
      params.require(:link).permit(:title, :url_link, :icon)
    end
end
