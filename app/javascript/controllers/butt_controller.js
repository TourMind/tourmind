import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="butt"
export default class extends Controller {
  static targets = ["form"];

  toggleCommentForm() {
    this.formTarget.classList.toggle("hidden");
  }
}