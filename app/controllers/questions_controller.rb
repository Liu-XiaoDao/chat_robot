class QuestionsController < ApplicationController
  def index
    @questions = Question.all
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

  def advanced_search
    if request.xhr?
      @articles = Question.search_by_token params[:search_text]
      @article_size = @articles.size
      respond_to do |format|
        format.js { render :advanced_search }
        format.html { render :articles, layout: 'community' }
      end
    else
      @categorys = Category.all
      @questions = Question.order(:view_count).first(10)
    end
  end


  def new
    @question = Question.new
    @categorys = Category.all
  end

  def create
    @question = Question.create(question_params)
    redirect_to questions_path
  end

  def show
    @question = Question.find(params[:id])
  end

  #保存图片
  def upload_img
    root_path = "#{Rails.root}/public"
    dir_path = "/images/#{Time.now.strftime('%Y%m')}"
    final_path = root_path + dir_path
    if !File.exist?(final_path)
      FileUtils.makedirs(final_path)
    end
    file_rename = "#{Digest::MD5.hexdigest(Time.now.to_s)}#{File.extname(params[:fileimg].original_filename)}"
    file_path = "#{final_path}/#{file_rename}"
    File.open(file_path,'wb+') do |item| #用二进制对文件进行写入
      item.write(params[:fileimg].read)
    end
    render json: {"errno": 0, "data": ["#{dir_path}/#{file_rename}"]}
  end

  private
    def question_params
      params.require(:question).permit(:title, :content, :category_id, :author)
    end


end





#  return render js: "$('#error-info').html('添加子类成功').css('display','block');"
