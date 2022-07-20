module GoldenIdea
  class SuggestsController < ApplicationController
    layout 'golden_idea_new'
    def index
      @suggests = Suggest.where(suggest_id: nil, site: current_employee.site)
      @suggests = @suggests.ransack(params[:q]).result(distinct: true).paginate page: params[:page], per_page: 8
    end

    def new
      @suggest = Suggest.new
      render layout: false
    end

    def create
      @suggest = Suggest.create(suggest_params)
      redirect_to golden_idea_suggests_path
    end

    def edit
      @suggest = Suggest.find params[:id]
      render layout: false
    end

    def update
      @suggest = Suggest.find params[:id]
      @suggest.update(suggest_params)
      redirect_to golden_idea_suggests_path
    end

    def reply
      @suggest = Suggest.find params[:id]
      @reply = @suggest.replys.new
      render layout: false
    end

    def show
      @suggest = Suggest.find params[:id]
    end

    def slide_show
      @suggest = Suggest.find params[:id]
    end

    def approve
      @suggest = Suggest.find params[:id]
      @suggest.update(status: 'Approve')
      redirect_to golden_idea_suggests_path
    end

    def reject
      @suggest = Suggest.find params[:id]
      @suggest.update(status: 'Reject')
      redirect_to golden_idea_suggests_path
    end

    private
      def suggest_params
        params.require(:golden_idea_suggest).permit(:title, :content, :real_name, :suggest_id)
      end
  end
end
