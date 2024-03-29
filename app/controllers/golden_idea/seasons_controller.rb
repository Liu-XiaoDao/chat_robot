class GoldenIdea::SeasonsController < ApplicationController
  layout 'golden_idea_new'
  def index
    @seasons = GoldenIdea::Season.where(site: current_employee.site).order(id: :desc).paginate page: params[:page], per_page: 10
  end

  # def index_admin
    # @seasons = GoldenIdea::Season.all
  # end

  def new
    @season = GoldenIdea::Season.new
    render layout: false
  end

  def create
    @season = GoldenIdea::Season.create(season_params)
    redirect_to golden_idea_seasons_path
  end

  def edit
    @season = GoldenIdea::Season.find params[:id]
    render layout: false
  end

  def update
    @season = GoldenIdea::Season.find(params[:id])
    if @season.update_attributes(season_params)
      flash["success"] = "Edit successfully"
    else
      flash["error"] = "Edit unsuccessfully:#{@season.errors.full_messages}"
    end
    redirect_to golden_idea_seasons_path
  end

  def show
    @season = GoldenIdea::Season.find(params[:id])
    @ideas = @season.ideas
  end

  # def show_admin
    # @season = GoldenIdea::Season.find(params[:id])
    # @ideas = @season.ideas
  # end

  private
    def season_params
      params.require(:golden_idea_season).permit(:name, :start_date, :end_date, {:collecters => []}, :description)
    end
end
