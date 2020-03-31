module GoldenIdea
  class ExchangeRecordsController < ApplicationController
    def index
      @exchange_records = ExchangeRecord.where(status: "待兑换")
    end

    def complete
      @exchange_records = ExchangeRecord.find(params[:id])
      if @exchange_records.update(status: "完成")
        flash["success"] = "兑换完成"
      else
        flash["error"] = "兑换失败"
      end
      redirect_to golden_idea_exchange_records_path
    end
  end
end
