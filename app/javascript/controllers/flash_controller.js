import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    dismissAfter: { type: Number, default: 5000 } // Time in ms after which the flash message disappears
  }

  connect() {
    // Only set timeout if dismissAfter is greater than 0
    if (this.dismissAfterValue > 0) {
      this.timeout = setTimeout(() => this.dismiss(), this.dismissAfterValue)
    }
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  // Single method to handle both automatic and manual dismissal
  dismiss() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }

    this.element.style.opacity = 0

    // Use the same transition duration as defined in CSS (0.5s)
    setTimeout(() => this.element.remove(), 500)
  }
}
