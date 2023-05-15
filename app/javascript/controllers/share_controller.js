import { Controller } from "@hotwired/stimulus";
import { get, post } from "@rails/request.js";
import Swal from "sweetalert2";

// Connects to data-controller="share"
export default class extends Controller {
  static targets = [
    "searchBtn",
    "menu",
    "keyword",
    "result",
    "shareBtn",
    "sharedList",
    "addBtn",
    "planId",
    "userCard",
    "editors",
    "removeBtn",
  ];

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

    this.id = this.planIdTarget.dataset.id;
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

    this.resultTarget.innerHTML = this.userCard(
      data.userId,
      data.profilePic,
      data.userName
    );
  }

  async addEditor() {
    this.addBtnTarget.innerHTML = this.loadingIcon();
    const res = await post(`/plans/${this.id}/add_editor`, {
      body: { userId: this.userCardTarget.dataset.id },
      responseKind: "json",
    });

    if (!res.ok) {
      this.addBtnTarget.innerHTML = "";
      return this.alertErrors("新增失敗");
    }

    const data = await res.json;
    this.addBtnTarget.innerHTML = this.checkIcon();

    if (this.editorsTarget.id === "empty") {
      this.editorsTarget.innerHTML = this.userCard(
        data.userId,
        data.profilePic,
        data.userName,
        "remove"
      );

      this.editorsTarget.id = "";
      return;
    }

    this.editorsTarget.insertAdjacentHTML(
      "beforeend",
      this.userCard(data.userId, data.profilePic, data.userName, "remove")
    );
  }

  async removeEditor() {
    this.removeBtnTarget.innerHTML = this.loadingIcon();
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

  toggleSharedList() {
    this.sharedListTarget.classList.toggle("search-drop-down");
    this.sharedListTarget.classList.toggle("search-drop-down-active");
    this.shareBtnTarget.classList.toggle("share-btn");
    this.shareBtnTarget.classList.toggle("share-btn-active");
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
      <div class="w-11 h-11">${this.loadingIcon()}</div>
    </div>`;
  }

  userCard(userId, profilePic, userName, option) {
    return `
    <div class="w-full flex p-3 pl-4 items-center rounded-lg justify-between" data-id=${userId} data-share-target="userCard">
      <div class="flex items-center">
        <div class="mr-4">
          <div class="h-11 w-11 rounded-sm flex items-center justify-center">
            <img class="w-full h-full rounded-full truncate" src="${profilePic}">
          </div>
        </div>
        <div>
          <div class="font-bold text-lg">${userName}</div>
        </div>
      </div>
      ${option === "remove" ? this.removeBtn() : this.addBtn()}
    </div>
    `;
  }

  errorCard() {
    return `
    <div class="w-full flex p-3 pl-4 items-center hover:bg-gray-300 rounded-lg cursor-pointer">
      <div class="mr-4 h-11 w-11">
        ${this.errorIcon()}
      </div>
      <div>
        <div class="font-bold text-lg">沒有這個使用者</div>
      </div>
    </div>`;
  }

  checkIcon() {
    return `
    <svg class="h-full w-full" height="200px" width="200px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 17.837 17.837" xml:space="preserve" fill="#669c35">
      <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
      <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
      <g id="SVGRepo_iconCarrier">
        <g><path style="fill:#77bb41;" d="M16.145,2.571c-0.272-0.273-0.718-0.273-0.99,0L6.92,10.804l-4.241-4.27 c-0.272-0.274-0.715-0.274-0.989,0L0.204,8.019c-0.272,0.271-0.272,0.717,0,0.99l6.217,6.258c0.272,0.271,0.715,0.271,0.99,0 L17.63,5.047c0.276-0.273,0.276-0.72,0-0.994L16.145,2.571z"></path>
        </g>
      </g>
    </svg>
    `;
  }

  loadingIcon() {
    return `
    <div class="inline-block h-full w-full animate-spin rounded-full border-4 border-solid border-current border-r-transparent align-[-0.125em] motion-reduce:animate-[spin_1.5s_linear_infinite]" role="status" data-edit-target="spinner">
    </div>
    `;
  }

  errorIcon() {
    return `
    <div class="w-full h-full rounded-sm flex items-center justify-center">
      <svg height="32" style="overflow:visible;enable-background:new 0 0 32 32" viewBox="0 0 32 32" width="32" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><g><g id="Error_1_"><g id="Error"><circle cx="16" cy="16" id="BG" r="16" style="fill:#D72828;"/><path d="M14.5,25h3v-3h-3V25z M14.5,6v13h3V6H14.5z" id="Exclamatory_x5F_Sign" style="fill:#E6E6E6;"/></g></g></g></svg>
    </div>
    `;
  }

  addBtn() {
    return `
    <div class="h-8 w-8 mr-3 cursor-pointer" data-share-target="addBtn" data-action="click->share#addEditor">
      <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 50 50" xml:space="preserve">
        <circle style="fill:#43B05C;" cx="25" cy="25" r="25"/>
        <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="25" y1="13" x2="25" y2="38"/>
        <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="37.5" y1="25" x2="12.5" y2="25"/>
      </svg>
    </div>
    `;
  }

  removeBtn() {
    return `
    <div class="h-8 w-8 mr-3 cursor-pointer" data-share-target="removeBtn" data-action="click->share#removeEditor">
      <svg class="w-full h-full" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="122.879px" height="122.879px" viewBox="0 0 122.879 122.879" enable-background="new 0 0 122.879 122.879" xml:space="preserve">
        <g>
          <path fill-rule="evenodd" clip-rule="evenodd" fill="#FF4141" d="M61.44,0c33.933,0,61.439,27.507,61.439,61.439 s-27.506,61.439-61.439,61.439C27.507,122.879,0,95.372,0,61.439S27.507,0,61.44,0L61.44,0z M73.451,39.151 c2.75-2.793,7.221-2.805,9.986-0.027c2.764,2.776,2.775,7.292,0.027,10.083L71.4,61.445l12.076,12.249 c2.729,2.77,2.689,7.257-0.08,10.022c-2.773,2.765-7.23,2.758-9.955-0.013L61.446,71.54L49.428,83.728 c-2.75,2.793-7.22,2.805-9.986,0.027c-2.763-2.776-2.776-7.293-0.027-10.084L51.48,61.434L39.403,49.185 c-2.728-2.769-2.689-7.256,0.082-10.022c2.772-2.765,7.229-2.758,9.953,0.013l11.997,12.165L73.451,39.151L73.451,39.151z"/>
        </g>
      </svg>
    </div>
    `;
  }
}
