import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="butt"
export default class extends Controller {
  static targets = ["form"]

  toggleCommentForm(event) {
    event.preventDefault()
    const form = this.formTarget
    form.classList.toggle("hidden")
    if (!form.classList.contains("hidden")) {
      form.scrollIntoView({ behavior: 'smooth' })
    }
  }
}