module GoldenIdea
  class ScoreRecordsController < ApplicationController
    def index
      @score_records = ScoreRecord.where(site: Employee.current_employee.site).paginate page: params[:page], per_page: 10
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
        flash["danger"] = ":#{@score_record.errors.full_messages.join(",")}"
      else
        flash["success"] = "Successfully"
      end
      redirect_to golden_idea_idea_path(@score_record.idea)
    end

    def update
      @score_record = ScoreRecord.find(params[:id])
      if @score_record.update_attributes(score_record_params)
        flash["success"] = "Edit successfully"
      else
        flash["danger"] = "Edit unsuccessfully"
      end
      redirect_to golden_idea_idea_path(@score_record.idea)
    end

    private
      def score_record_params
        params.require(:golden_idea_score_record).permit(:benefit, :cost, :risk, :idea_id)
      end
  end
end
