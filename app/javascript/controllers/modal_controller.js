import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "overlay"]

  connect() {
    this.hideModal()
    console.log('test')
  }

  showModal() {
    this.modalTarget.classList.remove("hidden")
    document.documentElement.classList.add("overflow-y-hidden")
  }

  hideModal() {
    this.modalTarget.classList.add("hidden")
    document.documentElement.classList.remove("overflow-y-hidden")
  }

  toggleModal() {
    if (this.modalTarget.classList.contains("hidden")) {
      this.showModal()
    } else {
      this.hideModal()
    }
  }

  overlayClick(event) {
    if (event.target === this.overlayTarget) {
      this.hideModal()
    }
  }
}