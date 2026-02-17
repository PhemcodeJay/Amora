# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user = User.find(params[:user_id])
    @like = current_user.like(@user)
    
    respond_to do |format|
      format.html { redirect_back fallback_location: browse_profiles_path, notice: @like.persisted? ? 'Like sent!' : 'Already liked' }
      format.json { render json: { matched: @like.status == 'matched' } }
      format.js
    end
  end
end