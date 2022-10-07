class NotificationMailer < ApplicationMailer

  GoldenIdeaReceivers =  [
    "jing.qian@abcam.com",
    "chuanwei.lu@abcam.com",
    "yanli.chen@abcam.com",
    "mengting.xu@abcam.com",
    "xingchao.lu@abcam.com",
    "sha.he@abcam.com",
    "peng.zeng@abcam.com",
    "tianqi.xing@abcam.com",
    "jingjing.zhang@abcam.com",
    "hui.wang@abcam.com",
    "wei.zhao@abcam.com",
    "xiong.fang@abcam.com",
    "jungang.chen@abcam.com",
    "yiting.zheng@abcam.com",
    "tao.jiang@abcam.com",
    "yingjie.li@abcam.com",
    "huimin.ma@abcam.com"
  ]

  def proposal(title, content, real_name)
    @title = title
    @content = content
    @real_name = real_name

    mail(to: GoldenIdeaReceivers, subject: "Proposal: #{@title}")
  end

  # 创建金点子之后给委员会发邮件
  def send_email_to_committee(idea)
    @idea = idea

    @idea.attachments.each do |a|
      attachments[a.attachment_file_name] = File.read(a.attachment.path)
    end
    mail(to: GoldenIdeaReceivers, subject: "New Idea: #{@idea.title}")
  end
end
