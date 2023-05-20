import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["keywordInput"]
  submitForm(e) {
    const keyword = this.keywordInputTarget.value.trim();
    if (keyword === "") {
      e.preventDefault();
    }
  }
}

