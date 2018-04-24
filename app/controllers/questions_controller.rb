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
  end

  def advanced_search
    if request.xhr?
      @articles = Question.search_by_token(params[:search_text], params[:category_text])
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
    @question.view_count += 1
    @question.save
    @count_record = @question.count_records.create(ip: request.remote_ip,type: "view_count")#这种类型是查看的记录
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

  def praise
    @question = Question.find(params[:id])
    @praise_record = @question.count_records.where(ip: request.remote_ip,type: "praise_count").first
    if @praise_record.blank?
      @count_record = @question.count_records.create(ip: request.remote_ip,type: "praise_count")#这种类型是点赞的记录
      @question.praise_count += 1
      @question.save
      render js: "$('#praise_count').html(#{@question.praise_count});"
    else
      render js: "alert('您已经点过赞了');"
    end
  end

  def rubbish
    @question = Question.find(params[:id])
    @praise_record = @question.count_records.where(ip: request.remote_ip,type: "rubbish_count").first
    if @praise_record.blank?
      @question.rubbish_count += 1
      @question.save
      @count_record = @question.count_records.create(ip: request.remote_ip,type: "rubbish_count")#这种类型是踩的记录
      render js: "$('#rubbish_count').html(#{@question.praise_count});"
    else
      render js: "alert('您已经踩过了');"
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :content, :content_html, :category_id, :author)
    end

end
