# app/models/profile.rb
class Profile < ApplicationRecord
  belongs_to :user
  has_many :profile_interests, dependent: :destroy
  has_many :interests, through: :profile_interests
  mount_uploader :photo, ProfilePhotoUploader
  
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
  
  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 18, less_than_or_equal_to: 100 }, allow_nil: true
  
  scope :by_age_range, ->(min, max) { where(age: min..max) if min.present? && max.present? }
  scope :by_gender, ->(gender) { where(gender: gender) if gender.present? }
  scope :by_interests, ->(interest_ids) {
    joins(:profile_interests)
      .where(profile_interests: { interest_id: interest_ids })
      .group('profiles.id')
      .having('COUNT(profile_interests.id) >= ?', interest_ids.size)
  }
  
  def compatible_profiles
    Profile.where.not(user_id: user_id)
           .where(looking_for: gender)
           .where(gender: looking_for)
  end
end