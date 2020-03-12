module ApplicationHelper
  def current_filter(season_id)
    GoldenIdea::Season.find(season_id).name
  end

  def sortable(column, title = nil)
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction).permit!, class: css_class
  end
end
