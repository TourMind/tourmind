import { Controller } from "@hotwired/stimulus";
import { post, destroy } from "@rails/request.js";
import Swal from "sweetalert2";

export default class extends Controller {
  static targets = ["section"];

  initialize() {
    this.Toast = Swal.mixin({
      toast: true,
      position: "top-end",
      customClass: {
        container: "flash_style",
      },
      showConfirmButton: false,
      timer: 2000,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener("mouseenter", Swal.stopTimer);
        toast.addEventListener("mouseleave", Swal.resumeTimer);
      },
    });
  }

  toggle(event) {
    event.preventDefault();
    const sectionName = event.target.dataset.section;
    this.sectionTargets.forEach((section) => {
      if (section.dataset.section === sectionName) {
        section.classList.remove("hidden");
      } else {
        section.classList.add("hidden");
      }
    });
  }

  async addFav(e) {
    const { id, type } = e.target.closest(".item").dataset;

    const res = await post("/favorites", {
      body: { favorable_type: type, favorable_id: id },
      responseKind: "json",
    });

    const data = await res.json;

    if (res.ok) {
      this.alert("success", "新增到喜愛清單");
      e.target.closest(".button").innerHTML =
        this.element.id === "show"
          ? this.longRemoveBtn(data.favorite_id)
          : this.removeBtn(data.favorite_id);
      return;
    }

    this.alert("error", "收藏失敗");
  }

  async removeFav(e) {
    const { id } = e.currentTarget.dataset;

    const res = await destroy(`/favorites/${id}`);

    if (res.ok) {
      this.alert("success", "已從喜愛清單中移除");
      e.target.closest(".button").innerHTML =
        this.element.id === "show" ? this.longAddBtn() : this.addBtn();
      return;
    }

    this.alert("error", "刪除失敗");
  }

  async removeFavCard(e) {
    const card = e.target.closest(".card");
    const { id } = card.dataset;

    const res = await destroy(`/favorites/${id}`);

    if (res.ok) {
      this.alert("success", "已從喜愛清單中移除");
      document.querySelectorAll(`.card-${id}`).forEach((el) => el.remove());
      this.updateCount();
      return;
    }

    this.alert("error", "刪除失敗");
  }

  updateCount() {
    document.querySelectorAll(".place").forEach((el) => {
      el.querySelector(".count").textContent =
        el.querySelectorAll(".card").length;
    });
  }

  alert(icon, title) {
    this.Toast.fire({
      icon,
      title,
    });
  }

  addBtn() {
    return `
    <div class="cursor-pointer" data-action="click->favorite#addFav">
      <span class="text-slate-300 text-4xl">&#x2665;</span>
    </div>
    `;
  }

  removeBtn(id) {
    return `
    <div class="cursor-pointer" data-action="click->favorite#removeFav" data-id="${id}">
      <span class="text-red-500 text-4xl">&#x2665;</span>
    </div>
    `;
  }

  longAddBtn() {
    return `
    <div class = "text-red-500 cursor-pointer select-none focus:outline-none focus:ring-4 font-medium rounded-full text-sm px-3 py-1 mx-2 bg-white hover:bg-rose-300 hover:text-white border-2" data-action="click->favorite#addFav">
      <span class="hidden sm:inline-block text-lg">加入喜愛清單</span>
      <span class="inline-block text-red-500 text-lg">&#x2665;</span>
    </div>
    `;
  }

  longRemoveBtn(id) {
    return `
    <div class = "bg-rose-300 cursor-pointer select-none text-white focus:outline-none focus:ring-4 font-medium rounded-full text-sm px-3 py-1 mx-2 hover:bg-white hover:text-red-500 border-2" data-action="click->favorite#removeFav" data-id="${id}">
      <span class="hidden sm:inline-block text-lg">已加喜愛清單</span>
      <span class="inline-block text-red-500 text-lg">&#x2665;</span>
    </div>
    `;
  }
}
