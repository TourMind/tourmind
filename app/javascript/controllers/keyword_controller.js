// Connects to data-controller="keyword"

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["keywordInput", "resetButton"]

  submitForm(event) {
    event.preventDefault();

    const keywordInput = this.keywordInputTarget;
    const keyword = keywordInput.value.trim();

    if (keyword !== "") {
      keywordInput.value = keyword;
      this.element.submit();
    }
  }
  resetForm(event) {
    event.preventDefault();
    const keywordInput = this.keywordInputTarget;
    if (keywordInput.value !== "") {
      keywordInput.value = "";
      this.element.submit();
    }
  }
}


