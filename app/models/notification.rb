class Notification < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true
  validates :notification_type, presence: true, inclusion: { in: %w[like match message] }
  
  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc).limit(50) }
  
  after_create_commit :broadcast_notification
  
  private
  
  def broadcast_notification
    NotificationChannel.broadcast_to(
      user,
      {
        id: id,
        content: content,
        type: notification_type,
        read: read,
        created_at: created_at,
        user: user.profile.name
      }
    )
  end
end