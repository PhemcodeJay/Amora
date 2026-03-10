module ProfilesHelper
  def gender_options
    [
      ["Select gender", ""],
      ["Male", "male"],
      ["Female", "female"],
      ["Other", "other"],
      ["Prefer not to say", "prefer_not_to_say"]
    ]
  end
  
  def looking_for_options
    [
      ["Select preference", ""],
      ["Men", "male"],
      ["Women", "female"],
      ["Everyone", "everyone"]
    ]
  end
  
  def age_range_options
    (18..100).map { |age| [age, age] }
  end
  
  def compatibility_color(score)
    case score
    when 80..100 then "text-green-600"
    when 60..79 then "text-yellow-600"
    else "text-gray-600"
    end
  end
  
  def profile_completion_percentage(profile)
    fields = [
      profile.name.present?,
      profile.age.present?,
      profile.location.present?,
      profile.bio.present?,
      profile.gender.present?,
      profile.looking_for.present?,
      profile.photo?,
      profile.interests.any?
    ]
    
    (fields.count(true).to_f / fields.count * 100).round
  end
  
  def completion_message(percentage)
    if percentage < 50
      "Complete your profile to get more matches!"
    elsif percentage < 80
      "Almost there! Add more details to your profile."
    else
      "Great profile! You're ready to find matches."
    end
  end
end