require "application_system_test_case"

class MatchingFlowTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
    @other_user = users(:two)
  end
  
  test "user can browse profiles and like someone" do
    sign_in(@user)
    
    visit browse_profiles_path
    
    assert_selector "h1", text: "Browse Profiles"
    
    first(".like-button").click
    
    assert_text "Like sent!"
  end
  
  test "users get matched when they like each other" do
    sign_in(@user)
    
    # User likes other user
    visit browse_profiles_path
    first(".like-button").click
    
    # Sign in as other user
    sign_out(@user)
    sign_in(@other_user)
    
    # Other user likes back
    visit browse_profiles_path
    first(".like-button").click
    
    # Check for match notification
    assert_selector ".notification", text: "You matched with"
    
    # Visit matches page
    visit matches_path
    assert_selector ".match-card", count: 1
  end
  
  test "matched users can send messages" do
    # Create a match
    match = Match.create(
      user1: @user,
      user2: @other_user,
      status: 'active'
    )
    
    sign_in(@user)
    
    visit match_messages_path(match)
    
    fill_in "message[content]", with: "Hello there!"
    click_on "Send"
    
    assert_selector ".message", text: "Hello there!"
    
    # Sign in as other user
    sign_out(@user)
    sign_in(@other_user)
    
    visit match_messages_path(match)
    
    assert_selector ".message", text: "Hello there!"
  end
end