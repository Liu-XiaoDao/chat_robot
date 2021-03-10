module ApplicationHelper
  def current_filter(season_id)
    GoldenIdea::Season.find(season_id).name
  end

  def sortable(column, title = nil)
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction).permit!, class: css_class
  end

  # idea是否从上期转移过来
  def is_transfer?(idea)
    idea.season_id != idea.origin_season_id ? "warning" : ""
  end

  # 检查当前页
  def active?(text, path)
    text == path ? "active" : ""
  end

  # 检查当前页的上级
  def active_patent?(text, path)
    path.include?(text) ? "active" : ""
  end

  # 是否打开折叠菜单
  def menu_open?(text, path)
    path.include?(text) ? "menu-open" : ""
  end
end
