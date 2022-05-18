class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:id])
    if @attachment.destroy
      flash["success"] = "Delete successfully"
    else
      flash["error"] = "Delete unsuccessfully"
    end
    redirect_to request.referer
  end
end
