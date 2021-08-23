module GoldenIdea
  class ScoreRecordsController < ApplicationController
    def index

    end

    def new
      @score_record = ScoreRecord.find params[:id]
      render layout: false
    end

    def edit
      @score_record = ScoreRecord.find params[:id]
      render layout: false
    end

    def create
      @score_record = ScoreRecord.create(score_record_params)
      if @score_record.errors.present?
        flash["danger"] = "打分不成功:#{@score_record.errors.full_messages.join(",")}"
      else
        flash["success"] = "打分成功"
      end
      redirect_to golden_idea_idea_path(@score_record.idea)
    end

    def update
      @score_record = ScoreRecord.find(params[:id])
      if @score_record.update_attributes(score_record_params)
        flash["success"] = "修改成功"
      else
        flash["danger"] = "修改不错误"
      end
      redirect_to golden_idea_idea_path(@score_record.idea)
    end

    private
      def score_record_params
        params.require(:golden_idea_score_record).permit(:benefit, :cost, :risk, :idea_id)
      end
  end
end
