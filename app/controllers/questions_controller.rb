class QuestionsController < ApplicationController
  def index
  end

  def search
    @articles = Question.search_by_token params[:term]
    @article_size = @articles.size
    respond_to do |format|
      format.js { render :show }
      format.html { render :articles, layout: 'community' }
    end
   # render json: @articles
   # render json: ( @articles.map_with_hit {|record, hit| Hash[ id: record.id, label: record.title, name: record.content]})
  end

end





#  return render js: "$('#error-info').html('添加子类成功').css('display','block');"