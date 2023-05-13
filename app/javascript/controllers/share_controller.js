import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

// Connects to data-controller="share"
export default class extends Controller {
  static targets = ["searchBtn", "menu", "keyword", "result"];

  searchUser(e) {
    e.preventDefault();
    this.clearResult();
    this.showResultBox();

    const user = `
    <div class="w-full justify-center flex p-3 pl-4 items-center hover:bg-gray-300 rounded-lg cursor-pointer">
      <div class="inline-block h-11 w-11 animate-spin rounded-full border-4 border-solid border-current border-r-transparent align-[-0.125em] motion-reduce:animate-[spin_1.5s_linear_infinite]" role="status" data-edit-target="spinner">
      </div>
    </div>`;

    this.resultTarget.insertAdjacentHTML("afterbegin", user);
  }

  preventProp(e) {
    e.stopPropagation();
  }

  toggleSearch() {
    this.menuTarget.classList.toggle("search-drop-down");
    this.menuTarget.classList.toggle("search-drop-down-active");
    this.searchBtnTarget.classList.toggle("share-btn");
    this.searchBtnTarget.classList.toggle("share-btn-active");
    this.hideResultBox();
    this.clearResult();
  }

  hideResultBox() {
    this.resultTarget.classList.add("result-hidden");
    this.resultTarget.classList.remove("result-active");
  }

  showResultBox() {
    this.resultTarget.classList.remove("result-hidden");
    this.resultTarget.classList.add("result-active");
  }

  clearResult() {
    this.resultTarget.innerHTML = "";
  }
}
