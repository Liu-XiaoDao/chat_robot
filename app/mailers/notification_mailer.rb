class NotificationMailer < ApplicationMailer
  def proposal(title, content, real_name)
    @title = title
    @content = content
    @real_name = real_name

    mail(to: "hangoldenideas@abcam.com", subject: "合理化建议: #{@title}")
  end

  def send_email_to_committee(idea)
    @idea = idea

    mail(to: "hangoldenideas@abcam.com", subject: "New Idea: #{@idea.title}")
  end
end
