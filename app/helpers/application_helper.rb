module ApplicationHelper
  def page_title(title = "")
    base_title = "DatingApp"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
  
  def active_class(path)
    current_page?(path) ? "active" : ""
  end
  
  def format_date(date, format = :long)
    return unless date
    l(date, format: format)
  end
  
  def avatar_url(user, size = :thumb)
    if user.profile.photo?
      user.profile.photo.url(size)
    else
      asset_path("default-avatar.png")
    end
  end
  
  def online_status(user)
    if user.online?
      content_tag :span, "Online", class: "text-green-500 text-sm"
    else
      content_tag :span, "Offline", class: "text-gray-400 text-sm"
    end
  end
  
  def notification_badge(count)
    return unless count > 0
    
    content_tag :span, 
                count.to_s, 
                class: "absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center"
  end
  
  def interest_badge(interest)
    content_tag :span, 
                interest.name, 
                class: "bg-pink-100 text-pink-800 text-xs px-2 py-1 rounded"
  end
end