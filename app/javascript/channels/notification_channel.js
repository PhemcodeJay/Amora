import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    console.log("Connected to notifications")
  },

  disconnected() {
    console.log("Disconnected from notifications")
  },

  received(data) {
    this.showNotification(data)
    this.updateBadge()
  },

  showNotification(data) {
    const container = document.getElementById('notifications')
    if (!container) return

    const notification = document.createElement('div')
    notification.className = 'bg-white rounded-lg shadow-lg p-4 border-l-4 border-pink-500 animate-slide-in'
    notification.innerHTML = `
      <div class="flex items-start space-x-3">
        <div class="text-2xl">${this.getIcon(data.type)}</div>
        <div>
          <p class="text-sm font-medium text-gray-900">${data.content}</p>
          <p class="text-xs text-gray-500 mt-1">just now</p>
        </div>
      </div>
    `

    container.appendChild(notification)

    setTimeout(() => {
      notification.remove()
    }, 5000)
  },

  getIcon(type) {
    switch(type) {
      case 'like': return '❤️'
      case 'match': return '✨'
      case 'message': return '💬'
      default: return '📢'
    }
  },

  updateBadge() {
    const badge = document.querySelector('[data-notifications-target="badge"]')
    if (badge) {
      const count = parseInt(badge.textContent) + 1
      badge.textContent = count
      badge.classList.remove('hidden')
    }
  }
})