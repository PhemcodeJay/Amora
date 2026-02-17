# app/models/like.rb
class Like < ApplicationRecord
  belongs_to :liker, class_name: 'User'
  belongs_to :liked, class_name: 'User'
  
  validates :liker_id, uniqueness: { scope: :liked_id }
  validate :cannot_like_self
  after_create :send_notification
  
  private
  
  def cannot_like_self
    errors.add(:base, "You cannot like yourself") if liker_id == liked_id
  end
  
  def send_notification
    # Send real-time notification via ActionCable
    NotificationChannel.broadcast_to(
      liked,
      type: 'like',
      user: liker.profile.name,
      message: "#{liker.profile.name} liked your profile!"
    )
  end
end