class MatchNotificationJob < ApplicationJob
  queue_as :default
  
  def perform(match_id)
    match = Match.find(match_id)
    
    # Send email notifications
    MatchMailer.new_match_notification(match.user1, match.user2).deliver_later
    MatchMailer.new_match_notification(match.user2, match.user1).deliver_later
    
    # Create in-app notifications
    Notification.create(
      user: match.user1,
      content: "You matched with #{match.user2.profile.name}!",
      notification_type: 'match'
    )
    
    Notification.create(
      user: match.user2,
      content: "You matched with #{match.user1.profile.name}!",
      notification_type: 'match'
    )
  end
end