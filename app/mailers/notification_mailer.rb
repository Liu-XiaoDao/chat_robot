class NotificationMailer < ApplicationMailer

  GoldenIdeaReceivers =  [
    "jing.qian@abcam.com",
    "chuanwei.lu@abcam.com",
    "xin.zhang@abcam.com",
    "yanli.chen@abcam.com",
    "mengting.xu@abcam.com",
    "xingchao.lu@abcam.com",
    "sha.he@abcam.com",
    "peng.zeng@abcam.com",
    "tianqi.xing@abcam.com",
    "yuqian.ying@abcam.com",
    "jingjing.zhang@abcam.com",
    "hui.wang@abcam.com",
    "wei.zhao@abcam.com",
    "xiong.fang@abcam.com",
    "jungang.chen@abcam.com",
    "yiting.zheng@abcam.com",
    "chunliang.liu@abcam.com"
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
      attachments[a.attachment_file_name] = File.read(Rails.root.join("public#{a.attachment.url}"))
    end
    mail(to: GoldenIdeaReceivers, subject: "New Idea: #{@idea.title}")
  end
end
