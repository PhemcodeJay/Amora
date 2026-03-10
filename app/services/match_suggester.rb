# app/services/match_suggester.rb
class MatchSuggester
  def initialize(user)
    @user = user
    @profile = user.profile
  end
  
  def suggest(limit = 10)
    candidates = @profile.compatible_profiles
                        .where.not(user_id: @user.matched_users.pluck(:id))
    
    # Calculate compatibility score for each candidate
    candidates.map do |candidate|
      {
        profile: candidate,
        score: compatibility_score(candidate)
      }
    end.sort_by { |c| -c[:score] }.first(limit)
  end
  
  private
  
  def compatibility_score(candidate)
    score = 0
    
    # Age proximity (0-30 points)
    age_diff = (@profile.age - candidate.age).abs
    score += [30 - age_diff, 0].max
    
    # Common interests (0-40 points)
    common_interests = (@profile.interest_ids & candidate.interest_ids).count
    score += [common_interests * 10, 40].min
    
    # Location proximity (0-30 points)
    if @profile.latitude && @profile.longitude && candidate.latitude && candidate.longitude
      distance = Geocoder::Calculations.distance_between(
        [@profile.latitude, @profile.longitude],
        [candidate.latitude, candidate.longitude]
      )
      score += [30 - distance, 0].max
    end
    
    score
  end
end