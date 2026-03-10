require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "should create profile after create" do
    assert_not_nil @user.profile
  end
  
  test "should return matches" do
    other_user = User.create(
      email: "other@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    
    match = Match.create(
      user1_id: [@user.id, other_user.id].min,
      user2_id: [@user.id, other_user.id].max,
      status: 'active'
    )
    
    assert_includes @user.matches, match
  end
  
  test "should like another user" do
    other_user = User.create(
      email: "other@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    
    like = @user.like(other_user)
    assert like.persisted?
    assert_equal 'pending', like.status
  end
  
  test "should create match when both like each other" do
    user1 = @user
    user2 = User.create(
      email: "other@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    
    user1.like(user2)
    user2.like(user1)
    
    assert user1.matches.any?
    assert user2.matches.any?
  end
end