import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.hideOnClickOutside = this.hideOnClickOutside.bind(this)
  }

  toggle() {
    if (this.menuTarget.classList.contains('hidden')) {
      this.show()
    } else {
      this.hide()
    }
  }

  show() {
    this.menuTarget.classList.remove('hidden')
    document.addEventListener('click', this.hideOnClickOutside)
  }

  hide() {
    this.menuTarget.classList.add('hidden')
    document.removeEventListener('click', this.hideOnClickOutside)
  }

  hideOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.hide()
    }
  }
}