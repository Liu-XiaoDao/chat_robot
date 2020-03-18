class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:id])
    if @attachment.destroy
      flash["success"] = "删除成功"
    else
      flash["error"] = "删除失败"
    end
    redirect_to request.referer
  end
end
