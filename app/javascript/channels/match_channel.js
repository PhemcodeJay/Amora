import consumer from "./consumer"

consumer.subscriptions.create("MatchChannel", {
  connected() {
    console.log("Connected to match channel")
  },

  disconnected() {
    console.log("Disconnected from match channel")
  },

  received(data) {
    const messagesContainer = document.getElementById('messages')
    if (messagesContainer) {
      messagesContainer.insertAdjacentHTML('beforeend', data.message)
      messagesContainer.scrollTop = messagesContainer.scrollHeight
    }
  }
})