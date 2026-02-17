class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from CanCan::AccessDenied, with: :unauthorized
  
  private
  
  def not_found
    render json: { error: "Resource not found" }, status: :not_found
  end
  
  def unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end