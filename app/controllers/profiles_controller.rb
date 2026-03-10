# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]
  
  def show
  end
  
  def edit
  end
  
  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end
  
  def browse
    @profiles = current_user.profile.compatible_profiles
                           .where.not(user_id: current_user.sent_likes.pluck(:liked_id))
    
    # Apply filters
    @profiles = @profiles.by_age_range(params[:min_age], params[:max_age])
    @profiles = @profiles.by_gender(params[:gender]) if params[:gender].present?
    
    if params[:interest_ids].present?
      @profiles = @profiles.by_interests(params[:interest_ids])
    end
    
    # Pagination
    @profiles = @profiles.page(params[:page]).per(20)
  end
  
  private
  
  def set_profile
    @profile = current_user.profile
  end
  
  def profile_params
    params.require(:profile).permit(:name, :bio, :age, :location, :gender, :looking_for, :photo, interest_ids: [])
  end
end