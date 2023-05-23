import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "submit"]

  connect(){
    this.checkInput();
  }

  checkInput() {
    const inputValue = this.inputTarget.value.trim();

    if (inputValue === "") {
      this.submitTarget.disabled = true;
    } else {
      this.submitTarget.disabled = false;
    }
  }
}