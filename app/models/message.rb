# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user
  validates :content, presence: true
  
  after_create_commit { broadcast_message }
  after_create :send_notification
  
  private
  
  def broadcast_message
    MatchChannel.broadcast_to(
      match,
      message: render_message,
      user_id: user_id
    )
  end
  
  def render_message
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: self })
  end
  
  def send_notification
    recipient = match.other_user(user)
    Notification.create(
      user: recipient,
      content: "New message from #{user.profile.name}",
      notification_type: 'message'
    )
    
    NotificationChannel.broadcast_to(
      recipient,
      type: 'message',
      match_id: match.id,
      message: "New message from #{user.profile.name}"
    )
  end
end