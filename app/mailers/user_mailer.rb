class UserMailer < ApplicationMailer
  def new_message_notification(user, message)
    @user = user
    @message = message
    @sender = message.user
    mail(to: @user.email, subject: "New message from #{@sender.profile.name}")
  end
  
  def weekly_activity_report(user, stats)
    @user = user
    @stats = stats
    mail(to: @user.email, subject: "Your weekly dating app activity")
  end
end