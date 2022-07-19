class NotificationMailer < ApplicationMailer
  def proposal(title, content, real_name)
    @title = title
    @content = content
    @real_name = real_name

    mail(to: ['chuanwei.lu@abcam.com', 'fan.ren@abcam.com', 'jing.qian@abcam.com', 'jingjing.xu@abcam.com', 'mengting.xu@abcam.com', 'peng.zeng@abcam.com', 'senliang.guo@abcam.com', 'sha.he@abcam.com', 'tianqi.xing@abcam.com', 'xin.zhang@abcam.com', 'xingchao.lu@abcam.com', 'yanli.chen@abcam.com', "xiong.fang@abcam.com", "chunliang.liu@abcam.com"], subject: "Proposal: #{@title}")
  end

  # 创建金点子之后给委员会发邮件
  def send_email_to_committee(idea)
    @idea = idea

    @idea.attachments.each do |a|
      attachments[a.attachment_file_name] = File.read(Rails.root.join("public#{a.attachment.url}"))
    end
    mail(to: ['chuanwei.lu@abcam.com', 'fan.ren@abcam.com', 'jing.qian@abcam.com', 'jingjing.xu@abcam.com', 'mengting.xu@abcam.com', 'peng.zeng@abcam.com', 'senliang.guo@abcam.com', 'sha.he@abcam.com', 'tianqi.xing@abcam.com', 'xin.zhang@abcam.com', 'xingchao.lu@abcam.com', 'yanli.chen@abcam.com', "xiong.fang@abcam.com", "chunliang.liu@abcam.com"], subject: "New Idea: #{@idea.title}")
  end
end
