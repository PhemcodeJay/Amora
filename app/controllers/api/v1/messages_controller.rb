class Api::V1::MessagesController < Api::V1::BaseController
  before_action :set_match
  
  def index
    @messages = @match.messages.includes(:user)
                      .order(created_at: :desc)
                      .limit(50)
    render json: @messages, each_serializer: MessageSerializer
  end
  
  def create
    @message = @match.messages.create(
      user: current_user,
      content: params[:content]
    )
    
    if @message.persisted?
      render json: @message, serializer: MessageSerializer, status: :created
    else
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_match
    @match = Match.find(params[:match_id])
    render json: { error: "Unauthorized" }, status: :unauthorized unless authorized?
  end
  
  def authorized?
    @match.user1 == current_user || @match.user2 == current_user
  end
end