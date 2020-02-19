module GoldenIdea
  class IdeasController < ApplicationController
    layout 'golden_idea'
    def index
      @golden_ideas = Idea.ransack(params[:q]).result(distinct: true).paginate page: params[:page], per_page: 10
    end

    def index_admin
      @golden_ideas = Idea.ransack(params[:q]).result(distinct: true).paginate page: params[:page], per_page: 10
    end

    def current_season_index
      @golden_ideas = Idea.where(season_id: Season.last.id)
    end

    def current_season_index_admin
      @golden_ideas = Idea.where(season_id: Season.last.id)
    end

    def new
      @golden_idea = Idea.new
      render layout: false
    end

    def create
      @golden_idea = Idea.create(golden_idea_params)
      redirect_to index_admin_golden_idea_ideas_path
    end

    def edit
      @golden_idea = Idea.find params[:id]
      render layout: false
    end

    def edit_content
      @golden_idea = Idea.find params[:id]
    end

    def update
      @golden_idea = Idea.find(params[:id])
      if @golden_idea.update_attributes(golden_idea_params)
        save_attachments if params[:attachment_files]
        flash["success"] = "编辑成功"
      else
        flash["error"] = "编辑错误:#{@golden_idea.errors.full_messages}"
      end
      # redirect_to index_admin_golden_idea_ideas_path
      redirect_to request.referer
    end

    def show_admin
      @golden_idea = Idea.find(params[:id])
      # @golden_ideas = @season.golden_ideas
    end

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
      employees.each do |i, v|
        employee = Employee.find(i)
        employee.update(score: (employee.score.to_i + v.to_i))
      end
      flash[:success] = "积分分配成功"
      redirect_to show_admin_golden_idea_idea_path(@golden_idea)
    end

    private
      def golden_idea_params
        params.require(:golden_idea_idea).permit(:title, :category, {:proposers => []}, :department, :description, :content, :score)
      end
  end
end
