# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match
  
  def index
    @messages = @match.messages.includes(:user).order(created_at: :asc)
    @message = Message.new
  end
  
  def create
    @message = @match.messages.create(
      user: current_user,
      content: params[:message][:content]
    )
    
    respond_to do |format|
      format.turbo_stream
      format.json { render json: @message }
    end
  end
  
  private
  
  def set_match
    @match = Match.find(params[:match_id])
    redirect_to root_path unless @match.user1 == current_user || @match.user2 == current_user
  end
end