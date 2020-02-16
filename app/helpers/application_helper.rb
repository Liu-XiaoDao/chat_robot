module ApplicationHelper
  def current_filter(season_id)
    GoldenIdea::Season.find(season_id).name
  end
end
