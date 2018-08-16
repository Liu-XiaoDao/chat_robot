class ExceptionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.exception_mailer.exception_nitofy.subject
  #

  default from: Rails.env == "production" ? "宜康快递助手 <no-reply@abcam.com>" : "小刀 <liu_xiaodao@163.com>"

  def exception_nitofy
    @greeting = "Hi"

    mail to: "957419420@qq.com", subject: "宜康快递助手异常通知"
  end

end
