class MatchesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @matches = current_user.matches.includes(:user1, :user2)
                          .order(updated_at: :desc)
                          .page(params[:page])
                          .per(20)
  end
  
  def show
    @match = Match.find(params[:id])
    redirect_to root_path unless @match.user1 == current_user || @match.user2 == current_user
    
    @messages = @match.messages.includes(:user).order(created_at: :asc)
    @message = Message.new
  end
end