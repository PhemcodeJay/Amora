class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      @features = [
        { title: "Find Matches", description: "Discover people who share your interests", icon: "heart" },
        { title: "Real-time Chat", description: "Connect instantly with your matches", icon: "chat" },
        { title: "Smart Suggestions", description: "AI-powered match recommendations", icon: "star" }
      ]
    end
  end
end