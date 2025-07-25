import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["spinner"]

  connect() {
    document.addEventListener("turbo:submit-start", this.showSpinner)
    document.addEventListener("turbo:submit-end", this.hideSpinner)
  }

  disconnect() {
    document.removeEventListener("turbo:submit-start", this.showSpinner)
    document.removeEventListener("turbo:submit-end", this.hideSpinner)
  }

  showSpinner = () => {
    if (this.hasSpinnerTarget) {
      this.spinnerTarget.style.display = "inline"
    }
  }

  hideSpinner = () => {
    if (this.hasSpinnerTarget) {
      this.spinnerTarget.style.display = "none"
    }
  }
}
