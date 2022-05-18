module GoldenIdea
  class ExchangeRecordsController < ApplicationController
    def index
      @exchange_records = ExchangeRecord.where(status: "pending")
      respond_to { |format|
        format.html
        format.xlsx { send_data ExchangeRecord.to_xlsx(@exchange_records).stream.string, filename: "exchange_records.xlsx", disposition: 'attachment' }
      }
    end

    def complete
      @exchange_records = ExchangeRecord.find(params[:id])
      if @exchange_records.update(status: "complete")
        flash["success"] = "Exchange successfully"
      else
        flash["error"] = "Exchange unsuccessfully"
      end
      redirect_to golden_idea_exchange_records_path
    end
  end
end
