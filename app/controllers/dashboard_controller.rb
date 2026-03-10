# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @matches = current_user.matches.includes(:user1, :user2).order(created_at: :desc).limit(10)
    @messages = Message.where(match_id: @matches.pluck(:id))
                      .order(created_at: :desc)
                      .limit(20)
    @suggestions = current_user.profile.compatible_profiles
                               .where.not(user_id: current_user.matched_users.pluck(:id))
                               .order('RANDOM()')
                               .limit(10)
  end
end