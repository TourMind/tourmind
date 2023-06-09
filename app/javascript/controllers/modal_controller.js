import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "overlay", "frame"]

  connect() {
    this.hideModal()
  }

  showModal() {
    this.modalTarget.classList.remove("hidden")
    document.documentElement.classList.add("overflow-y-hidden")
  }

  hideModal() {
    this.modalTarget.classList.add("hidden")
    document.documentElement.classList.remove("overflow-y-hidden")
  }

  toggleModal(event) {
    this.toggle(event)
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

  toggle(event) {
    const frameName = event.target.dataset.frame
    this.frameTargets.forEach(frame => {
      if (frame.dataset.frame === frameName) {
        frame.classList.remove('hidden')
      } else {
        frame.classList.add('hidden')
      }
    })
  }
  
}
