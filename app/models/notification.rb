class Notification < ApplicationRecord
  belongs_to :target, polymorphic: true
  after_create :send_notificaion

  def send_notificaion
    accessToken = AuthService.new.getAccessToken()
    data = {
      "touser":target.employee.userid,
      "agentid":180734473,
      "msgtype":"markdown",
      "markdown": {
        "title": target_type == "Book" ? "还书提醒" : "快递提醒",
        "text": "#{content}"
      }
    }
    msg = MessageService.new.send(accessToken,data)
    LogService.i("[发送消息反馈通知] INFO: #{msg}")
    if msg.code == 200
      target.update(is_send_noti: true) if target.is_a? Express
      LogService.i("[notification_send] SUC: 提醒发送成功,NotificationId:#{self.id}")
    else
      LogService.e("[notification_send] ERR: 提醒发送失败,NotificationId:#{self.id}")
    end
  end
end
