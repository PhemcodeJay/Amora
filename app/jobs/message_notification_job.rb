class MessageNotificationJob < ApplicationJob
  queue_as :default
  
  def perform(message_id)
    message = Message.find(message_id)
    recipient = message.match.other_user(message.user)
    
    # Send email notification if user is offline
    unless recipient.online?
      UserMailer.new_message_notification(recipient, message).deliver_later
    end
  end
end