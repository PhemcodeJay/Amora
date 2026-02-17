# app/models/interest.rb
class Interest < ApplicationRecord
  has_many :profile_interests, dependent: :destroy
  has_many :profiles, through: :profile_interests
  
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
end