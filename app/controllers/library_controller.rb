class LibraryController < ApplicationController
  layout 'library'
  def index
    if params[:category].present?
      @questions = Question.where(category_id: params[:category])
      @category_name = Category.find(params[:category]).try :category_name
    else
      @questions = Question.all
      @category_name = "全部"
    end
    @categorys = Category.all
  end

end
