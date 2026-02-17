# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
# Create interests
interests = [
  { name: "Hiking", category: "Outdoor" },
  { name: "Reading", category: "Indoor" },
  { name: "Cooking", category: "Lifestyle" },
  { name: "Travel", category: "Adventure" },
  { name: "Photography", category: "Arts" },
  { name: "Music", category: "Arts" },
  { name: "Movies", category: "Entertainment" },
  { name: "Sports", category: "Fitness" },
  { name: "Yoga", category: "Fitness" },
  { name: "Gaming", category: "Entertainment" }
]

interests.each do |interest|
  Interest.find_or_create_by(name: interest[:name]) do |i|
    i.category = interest[:category]
  end
end

# Create sample users
5.times do |i|
  user = User.create!(
    email: "user#{i+1}@example.com",
    password: "password123",
    password_confirmation: "password123"
  )
  
  profile = user.profile
  profile.update!(
    name: Faker::Name.name,
    bio: Faker::Lorem.paragraph,
    age: rand(25..40),
    location: Faker::Address.city,
    gender: ['male', 'female'].sample,
    looking_for: ['male', 'female'].sample,
    interest_ids: Interest.pluck(:id).sample(3)
  )
end