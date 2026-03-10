module MessagesHelper
  def message_time(message)
    if message.created_at.today?
      message.created_at.strftime("%I:%M %p")
    else
      message.created_at.strftime("%b %d, %I:%M %p")
    end
  end
  
  def message_status(message)
    if message.read
      content_tag :span, "Read", class: "text-xs text-gray-400"
    else
      content_tag :span, "Delivered", class: "text-xs text-gray-500"
    end
  end
  
  def message_avatar(message)
    if message.user.profile.photo?
      image_tag message.user.profile.photo.url(:thumb), class: "w-6 h-6 rounded-full"
    else
      content_tag :div, 
                  message.user.profile.name.first.upcase,
                  class: "w-6 h-6 rounded-full bg-pink-100 text-pink-500 flex items-center justify-center text-sm font-bold"
    end
  end
  
  def unread_message_count(match)
    match.messages.where(read: false).where.not(user: current_user).count
  end
  
  def message_bubble_class(message)
    base = "max-w-xs lg:max-w-md rounded-lg px-4 py-2 shadow"
    
    if message.user == current_user
      "#{base} bg-pink-500 text-white"
    else
      "#{base} bg-gray-100 text-gray-800"
    end
  end
end