# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  has_one :profile, dependent: :destroy
  has_many :sent_likes, class_name: 'Like', foreign_key: 'liker_id', dependent: :destroy
  has_many :received_likes, class_name: 'Like', foreign_key: 'liked_id', dependent: :destroy
  has_many :matches_as_user1, class_name: 'Match', foreign_key: 'user1_id', dependent: :destroy
  has_many :matches_as_user2, class_name: 'Match', foreign_key: 'user2_id', dependent: :destroy
  has_many :sent_messages, class_name: 'Message', dependent: :destroy
  
  after_create :create_profile
  
  def matches
    Match.where("(user1_id = ? OR user2_id = ?) AND status = 'active'", id, id)
  end
  
  def matched_users
    User.where(id: matches.pluck(:user1_id, :user2_id).flatten.uniq - [id])
  end
  
  def like(user)
    return if user == self || already_liked?(user)
    
    like = sent_likes.create(liked: user, status: 'pending')
    
    # Check if it's a match
    if user.sent_likes.exists?(liked: self)
      create_match(user)
      like.update(status: 'matched')
      user.sent_likes.find_by(liked: self).update(status: 'matched')
    end
    
    like
  end
  
  def already_liked?(user)
    sent_likes.exists?(liked: user)
  end
  
  private
  
  def create_profile
    build_profile.save
  end
  
  def create_match(other_user)
    match = Match.create(
      user1_id: [id, other_user.id].min,
      user2_id: [id, other_user.id].max,
      status: 'active'
    )
    
    # Create notification for both users
    Notification.create(user: self, content: "You matched with #{other_user.profile.name}!", notification_type: 'match')
    Notification.create(user: other_user, content: "You matched with #{profile.name}!", notification_type: 'match')
    
    match
  end
end