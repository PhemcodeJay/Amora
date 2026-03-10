import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "container"]

  connect() {
    this.scrollToBottom()
  }

  scrollToBottom() {
    if (this.hasContainerTarget) {
      this.containerTarget.scrollTop = this.containerTarget.scrollHeight
    }
  }

  resetForm() {
    this.element.reset()
  }

  handleKeydown(event) {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault()
      this.element.requestSubmit()
    }
  }
}