class MatchMailer < ApplicationMailer
  def new_match_notification(user, matched_user)
    @user = user
    @matched_user = matched_user
    mail(to: @user.email, subject: "You have a new match!")
  end
  
  def daily_match_summary(user, new_matches)
    @user = user
    @new_matches = new_matches
    mail(to: @user.email, subject: "Your daily match summary")
  end
end