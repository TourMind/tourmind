import { Controller } from "@hotwired/stimulus";
import Swal from "sweetalert2";
import { get } from "@rails/request.js";

// Connects to data-controller="share"
export default class extends Controller {
  static targets = ["searchBtn", "menu", "keyword", "result"];

  initialize() {
    this.Toast = Swal.mixin({
      toast: true,
      position: "top-end",
      customClass: {
        container: "flash_style",
      },
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener("mouseenter", Swal.stopTimer);
        toast.addEventListener("mouseleave", Swal.resumeTimer);
      },
    });
  }

  async searchUser(e) {
    e.preventDefault();
    const email = this.keywordTarget.value;

    if (!email) return this.alertErrors("請輸入email才能進行搜尋");

    const emailFormat =
      /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    if (!email.match(emailFormat)) {
      return this.alertErrors("請輸入正確的email格式");
    }

    this.keywordTarget.value = "";
    this.clearResult();
    this.showResultBox();
    this.resultTarget.innerHTML = this.loadingCard();

    const res = await get(`/check_user?email=${email}`);
    const data = await res.json;

    if (!res.ok) {
      this.resultTarget.innerHTML = this.errorCard();
      return;
    }

    this.resultTarget.innerHTML = this.userCard(data.profilePic, data.userName);
  }

  preventProp(e) {
    e.stopPropagation();
  }

  alertErrors(message) {
    this.Toast.fire({
      icon: "error",
      title: message,
    });
  }

  toggleSearch() {
    this.keywordTarget.value = "";
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

  loadingCard() {
    return `
    <div class="w-full justify-center flex p-3 pl-4 items-center hover:bg-gray-300 rounded-lg cursor-pointer">
      <div class="inline-block h-11 w-11 animate-spin rounded-full border-4 border-solid border-current border-r-transparent align-[-0.125em] motion-reduce:animate-[spin_1.5s_linear_infinite]" role="status" data-edit-target="spinner">
      </div>
    </div>`;
  }

  userCard(profilePic, userName) {
    return `
    <div class="w-full flex p-3 pl-4 items-center hover:bg-gray-300 rounded-lg cursor-pointer">
      <div class="mr-4">
        <div class="h-11 w-11 rounded-sm flex items-center justify-center">
          <img class="w-full h-full rounded-full truncate" src="${profilePic}">
        </div>
      </div>
      <div>
        <div class="font-bold text-lg">${userName}</div>
      </div>
    </div>
    `;
  }

  errorCard() {
    return `
    <div class="w-full flex p-3 pl-4 items-center hover:bg-gray-300 rounded-lg cursor-pointer">
      <div class="mr-4">
        <div class="h-11 w-11 rounded-sm flex items-center justify-center">
          <svg height="32" style="overflow:visible;enable-background:new 0 0 32 32" viewBox="0 0 32 32" width="32" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><g><g id="Error_1_"><g id="Error"><circle cx="16" cy="16" id="BG" r="16" style="fill:#D72828;"/><path d="M14.5,25h3v-3h-3V25z M14.5,6v13h3V6H14.5z" id="Exclamatory_x5F_Sign" style="fill:#E6E6E6;"/></g></g></g></svg>
        </div>
      </div>
      <div>
        <div class="font-bold text-lg">沒有這個使用者</div>
      </div>
    </div>`;
  }
}
