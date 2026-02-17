import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown"]

  connect() {
    this.hideOnClickOutside = this.hideOnClickOutside.bind(this)
  }

  toggle() {
    if (this.dropdownTarget.classList.contains('hidden')) {
      this.show()
    } else {
      this.hide()
    }
  }

  show() {
    this.dropdownTarget.classList.remove('hidden')
    document.addEventListener('click', this.hideOnClickOutside)
    this.markAsRead()
  }

  hide() {
    this.dropdownTarget.classList.add('hidden')
    document.removeEventListener('click', this.hideOnClickOutside)
  }

  hideOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.hide()
    }
  }

  markAsRead() {
    fetch('/notifications/mark_as_read', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
        'Content-Type': 'application/json'
      }
    })
  }
}