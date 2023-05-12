import { Controller } from "@hotwired/stimulus";
import { patch, post } from "@rails/request.js";
import Swal from "sweetalert2";

// Connects to data-controller="send"
export default class extends Controller {
  static targets = [
    "name",
    "description",
    "category",
    "people",
    "container",
    "drawer",
    "images",
    "id",
    "form",
    "public",
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
  }

  async update() {
    try {
      const valid = this.trimDays();

      if (!valid) return this.alertErrors("行程不得為空白！");

      let locations = {};

      const dayCount = this.containerTarget.querySelectorAll(".day").length;

      for (let i = 1; i <= dayCount; i++) {
        locations[`day${i}`] = [];
        const sites = document
          .querySelector(`#plan-day-${i}`)
          .querySelectorAll(".site");

        sites.forEach((site) => {
          const updatedSite = site.id.split("-").map((el) => +el || el);
          updatedSite.push(site.querySelector(".stay-time").textContent);
          locations[`day${i}`].push(updatedSite);
        });
      }

      const id = this.idTarget.dataset.id;

      const form = new FormData();

      const files = this.imagesTarget.files;

      form.append("name", this.nameTarget.value);
      form.append("description", this.descriptionTarget.value);
      form.append("days", +this.containerTarget.dataset.days);
      form.append("people", +this.peopleTarget.value);
      form.append("public", this.publicTarget.checked);
      form.append("category", this.categoryTarget.value);
      form.append("locations", JSON.stringify(locations));

      for (let i = 0; i < files.length; i++) {
        form.append("images[]", files[i]);
      }

      let res;

      if (!id) {
        res = await post("/plans", {
          body: form,
          responseKind: "json",
        });
      } else {
        res = await patch(`/plans/${id}`, {
          body: form,
          responseKind: "json",
        });
      }

      const resInfo = await res.json;

      if (!res.ok) {
        return this.alertErrors(
          resInfo.errors.map((el) => el.split(" ")[1]).join("\n")
        );
      }

      window.location.replace(resInfo.redirect_url);
    } catch (err) {
      console.log(err);
    }
  }

  addDay() {
    const dayElement = `
    <div class="relative px-4 day min-h-[150px] bg-white">
      <div class="flex justify-between items-center">
        <h4 class="text-xl text-gray-900 font-bold day-title">第 ${
          +this.containerTarget.dataset.days + 1
        } 天</h4>
        <button data-action="click->edit#deleteDay" type="button" class="bg-gray-100 rounded-md p-2 flex text-gray-400 hover:text-gray-500 hover:bg-gray-200">
          <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
      </div>
      <div class="absolute h-full border border-dashed border-opacity-20 border-slate-600"></div>
      <div data-controller="sorting" class="h-full w-full sites-list" id="plan-day-${
        +this.containerTarget.dataset.days + 1
      }">
      </div>
    </div>`;

    this.containerTarget.dataset.days = +this.containerTarget.dataset.days + 1;
    this.containerTarget.insertAdjacentHTML("beforeend", dayElement);
  }

  removeDay() {
    if (+this.containerTarget.dataset.days <= 1) {
      return this.alertErrors("行程不得少於一天");
    }

    const sitesInLastDay = this.containerTarget.lastElementChild
      .querySelector(".sites-list")
      .querySelectorAll(".site").length;

    if (sitesInLastDay) {
      return this.alertErrors("移除天數前，請先移除該天所有行程。");
    }

    this.containerTarget.dataset.days = +this.containerTarget.dataset.days - 1;
    this.containerTarget.lastElementChild.remove();
  }

  trimDays() {
    const sitesInLastDay = this.containerTarget.lastElementChild
      .querySelector(".sites-list")
      .querySelectorAll(".site").length;

    if (+this.containerTarget.dataset.days === 1 && sitesInLastDay === 0) {
      return false;
    }

    if (sitesInLastDay) return true;

    this.containerTarget.dataset.days = +this.containerTarget.dataset.days - 1;
    this.containerTarget.lastElementChild.remove();
    return this.trimDays();
  }

  toggleFav() {
    this.drawerTarget.classList.toggle("-translate-x-56");
    this.formTarget.classList.toggle("w-full");
    this.formTarget.classList.toggle("w-10/12");
  }

  alertErrors(message) {
    this.Toast.fire({
      icon: "error",
      title: message,
    });
  }

  deleteDay(e) {
    const day = e.target.closest(".day");
    const siteInDay = day.querySelectorAll(".site").length;

    if (siteInDay) return this.alertErrors("刪除之前請先移除當天所有行程");

    day.remove();
    this.updateOrder();
  }

  updateOrder() {
    const days = this.containerTarget.querySelectorAll(".day");
    this.containerTarget.dataset.days = days.length;
    days.forEach((day, i) => {
      day.querySelector(".day-title").textContent = `第 ${i + 1} 天`;
      day.querySelector(".sites-list").id = `plan-day-${i + 1}`;
    });
  }
}
