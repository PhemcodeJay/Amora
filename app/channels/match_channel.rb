# app/channels/match_channel.rb
class MatchChannel < ApplicationCable::Channel
  def subscribed
    @match = Match.find(params[:match_id])
    stream_for @match if authorized?
  end
  
  def unsubscribed
    stop_all_streams
  end
  
  private
  
  def authorized?
    @match.user1 == current_user || @match.user2 == current_user
  end
end