import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="share"
export default class extends Controller {
  static targets = ["searchBtn", "menu"];

  connect() {
    this.menuTarget.addEventListener("click", (e) => {
      e.stopPropagation();
    });
  }

  toggleSearch() {
    this.menuTarget.classList.toggle("opacity-0");
    this.menuTarget.classList.toggle("top-1/2");
    this.menuTarget.classList.toggle("top-full");
    this.menuTarget.classList.toggle("pointer-events-none");
  }
}
