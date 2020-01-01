class GoldenIdea::SeasonsController < ApplicationController
  layout 'golden_idea'
  def index
    @seasons = Season.all
  end

  def index_admin
    @seasons = GoldenIdea::Season.all
  end

  def new
    @season = GoldenIdea::Season.new
    render layout: false
  end

  def create
    @season = GoldenIdea::Season.create(season_params)
    redirect_to index_admin_golden_idea_seasons_path
  end
  private
    def season_params
      params.require(:golden_idea_season).permit(:name)
    end
end
