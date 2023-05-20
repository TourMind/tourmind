

// // Connects to data-controller="search"


import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["keywordInput"]

  submitForm(event) {
    event.preventDefault();

    const keywordInput = this.keywordInputTarget;
    const keyword = keywordInput.value.trim();

    if (keyword !== "") {
      keywordInput.value = keyword;
      this.element.submit();
    } else {
      console.log("Input field is empty. Form not submitted.");
    }
  }
}


