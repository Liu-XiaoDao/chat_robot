class QuestionsController < ApplicationController
  def index
  end

  def search
    @articles = Question.search_by_token params[:token]
    @article_size = @articles.size
    respond_to do |format|
      format.js { render :show }
      format.html { render :articles, layout: 'community' }
    end
#    render json: @articles
  end
#  return render js: "$('#error-info').html('添加子类成功').css('display','block');"
end
