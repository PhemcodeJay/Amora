class InterestsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = Interest.pluck(:category).uniq
    @interests = Interest.all.group_by(&:category)
  end
end