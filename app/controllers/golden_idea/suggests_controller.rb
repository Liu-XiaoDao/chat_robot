module GoldenIdea
  class SuggestsController < ApplicationController
    layout 'golden_idea_new'
    def index
      @suggests = Suggest.where(suggest_id: nil)
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

    private
      def suggest_params
        params.require(:golden_idea_suggest).permit(:content, :suggest_id)
      end
  end
end
