module GoldenIdea
  class IdeasController < ApplicationController
    layout 'golden_idea_new'
    def index
      @golden_ideas = Idea.ransack(params[:q])
      @golden_ideas.sorts = sort_params || "id DESC"
      if params[:q] && params[:q][:proposer]
        sql = ''
        params[:q][:proposer].each do |p_id|
          sql += "find_in_set(#{p_id},proposer) or "
        end
        sql.slice!(-4, 4) if sql.present?
        @golden_ideas = @golden_ideas.result(distinct: true).where(sql)
      else
        @golden_ideas = @golden_ideas.result(distinct: true)
      end
      @golden_ideas = @golden_ideas.paginate page: params[:page], per_page: 10

      respond_to { |format|
        format.html
        format.xlsx { send_data Idea.to_xlsx(@golden_ideas).stream.string, filename: "golden_ideas.xlsx", disposition: 'attachment' }
      }
    end

    #def index_admin
    #  @golden_ideas = Idea.ransack(params[:q]).result(distinct: true).paginate page: params[:page], per_page: 10
    #end

    def current_season_index
      @golden_ideas = Idea.where(season_id: Season.last.id)
      respond_to { |format|
        format.html
        format.xlsx { send_data Idea.to_xlsx(@golden_ideas).stream.string, filename: "golden_ideas.xlsx", disposition: 'attachment' }
      }
    end

    #def current_season_index_admin
    #  @golden_ideas = Idea.where(season_id: Season.last.id)
    #end

    def new
      @golden_idea = Idea.new
      # render layout: false
    end

    def create
      @golden_idea = Idea.new(golden_idea_params)
      if @golden_idea.save
        save_attachments if params[:attachment_files]
        save_sop_attachments if params[:sop_files]
        flash["success"] = "金点子创建成功，点‘击编辑内容’按钮编辑详情"
        redirect_to golden_idea_idea_path(@golden_idea)
      else
        render :new
      end
    end

    def edit
      @golden_idea = Idea.find params[:id]
      # render layout: false
    end

    #def edit_content
    #  @golden_idea = Idea.find params[:id]
    #end

    def update
      @golden_idea = Idea.find(params[:id])
      if @golden_idea.update_attributes(golden_idea_params)
        save_attachments if params[:attachment_files]
        save_sop_attachments if params[:sop_files]
        flash["success"] = "编辑成功"
        redirect_to golden_idea_idea_path(@golden_idea)
      else
        flash["error"] = "编辑错误:#{@golden_idea.errors.full_messages}"
        render :edit
      end
    end

    def show
      @golden_idea = Idea.find(params[:id])
      @score_record = @golden_idea.score_records.find_by_employee_id(current_employee.id)
      @score_record ||= @golden_idea.score_records.new
    end

    #def show_admin
    #  @golden_idea = Idea.find(params[:id])
    #  # @golden_ideas = @season.golden_ideas
    #end

    def score_view
      @golden_idea = Idea.find params[:id]
      render layout: false
    end

    def score
      @golden_idea = Idea.find params[:id]
      render layout: false
    end

    def employee_score_view
      @golden_idea = Idea.find params[:id]
      render layout: false
    end

    def employee_score
      @golden_idea = Idea.find params[:id]
      employees = params[:employees]
      flash[:success] = "积分分配成功"
      employees.each do |i, v|
        if Employee.find(i).assign_score(v.to_i)
          AssignScoreRecord.create(employee_id: i, idea_id: params[:id], score: v)
        else
          flash[:error] = "积分分配失败"
        end
      end
      redirect_to golden_idea_idea_path(@golden_idea)
    end

    def destroy
      @golden_idea = Idea.find(params[:id])
      @golden_idea.destroy

      redirect_to current_season_index_golden_idea_ideas_path
    end

    def search
      @golden_ideas = Idea.search_name_by_token params[:term]
      @golden_ideas_size = @golden_ideas.size
      respond_to do |format|
        format.js { render :show }
      end
    end

    #批量上传
    # def import
      # if !params[:import][:file]
        # redirect_to golden_idea_ideas_path, alert: "You need select a file"
      # else
        # Idea.import(params[:import][:file])
        # redirect_to golden_idea_ideas_path, notice: "导入成功"
      # end
    # end

    def import_preview
      if !params[:import][:file]
        redirect_to golden_idea_ideas_path, alert: "You need select a file"
      else
        @ideas = Idea.import_preview(params[:import][:file])
        @ideas_cache_key = "ideas_#{SecureRandom.hex}"
        Rails.cache.write(@ideas_cache_key, @ideas, expires_in: 1.days)
      end
    end

    def import
      cr, er = 0, 0
      @ideas = Rails.cache.read(params[:cache_key])
      @ideas.map do |t|
        t.save ? cr += 1 : er += 1
      end
      Rails.cache.delete(params[:cache_key])
      info = (er == 0) ? :success : :danger
      flash[info] = "成功: " + cr.to_s  + " 失败: " + er.to_s
      redirect_to current_season_index_golden_idea_ideas_url
    end

    private
      def golden_idea_params
        params.require(:golden_idea_idea).permit(:title, :category, {:proposers => []}, :department, :description, :content, :score, :status, :reporter_id, :is_involve_sop)
      end
  end
end
