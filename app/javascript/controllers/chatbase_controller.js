import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["chatbaseBtn"];

  connect() {
  }

  toggleChatbaseBtn() {
    this.chatbaseBtnTarget.classList.toggle('hidden');
  }
}