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

    if (res.ok) {
      this.alert("success", "新增到喜愛清單");
      e.target.closest(".button").innerHTML = this.removeBtn();
      return;
    }

    this.alert("error", "收藏失敗");
  }

  async removeFav(e) {
    const { id, type } = e.target.closest(".item").dataset;
  }

  alert(icon, title) {
    this.Toast.fire({
      icon,
      title,
    });
  }

  removeBtn() {
    return `
    <div class="cursor-pointer" data-action="click->favorite#removeFav">
      <span class="text-red-500 text-4xl">&#x2665;</span>
    </div>
    `;
  }

  addBtn() {
    return `
    <div class="cursor-pointer" data-action="click->favorite#addFav">
      <span class="text-slate-300 text-4xl">&#x2665;</span>
    </div>
    `;
  }
}
