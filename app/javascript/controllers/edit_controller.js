import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";
// import { patch } from "@rails/request.js";

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
    "form",
    "public",
  ];

  async update() {
    try {
      this.trimDays();

      // const data = {
      //   name: this.nameTarget.value,
      //   description: this.descriptionTarget.value,
      //   days: +this.containerTarget.dataset.days,
      //   people: +this.peopleTarget.value,
      //   public: this.publicTarget.checked,
      //   category: this.categoryTarget.value,
      //   locations: {},
      // };

      let locations = {};

      const dayCount = document
        .querySelector("#plan")
        .querySelectorAll(".day").length;

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

      const id = document.querySelector("#top").dataset.id;

      const form = new FormData();

      const files = this.imagesTarget.files;

      form.append("name", this.nameTarget.value);
      form.append("description", this.descriptionTarget.value);
      form.append("days", +this.containerTarget.dataset.days);
      form.append("people", +this.peopleTarget.value);
      form.append("public", this.publicTarget.checked);
      form.append("category", this.categoryTarget.value);
      form.append("locations", JSON.stringify(locations));
      form.append("images", files[0]);
      // form.append("images", files[1]);

      // for (let i = 0; i < files.length; i++) {
      //   form.append("images", files[i]);
      // }

      const res = await patch(`/plans/${id}`, {
        body: form,
        responseKind: "json",
      });

      const resData = await res.json;

      if (!res.ok) {
        return alert(resData.errors);
      }

      window.location.replace(resData.redirect_url);
    } catch (err) {
      alert(err.message);
    }
  }

  addDay() {
    const dayElement = `
    <div class="relative px-4 day">
      <h4 class="text-xl text-gray-900 font-bold">第 ${
        +this.containerTarget.dataset.days + 1
      } 天</h4>
      <div class="absolute h-full border border-dashed border-opacity-20 border-slate-600"></div>
      <div data-controller="sorting" class="h-full w-full sites-list" id="plan-day-${
        +this.containerTarget.dataset.days + 1
      }">
        <div></div>
      </div>
    </div>`;

    this.containerTarget.dataset.days = +this.containerTarget.dataset.days + 1;
    this.containerTarget.insertAdjacentHTML("beforeend", dayElement);
  }

  removeDay() {
    if (+this.containerTarget.dataset.days <= 1) {
      return alert("行程不得少於一天");
    }

    const sitesInLastDay = this.containerTarget.lastElementChild
      .querySelector(".sites-list")
      .querySelectorAll(".site").length;

    if (sitesInLastDay) return alert("移除天數前，請先移除該天所有行程。");

    this.containerTarget.dataset.days = +this.containerTarget.dataset.days - 1;
    this.containerTarget.lastElementChild.remove();
  }

  trimDays() {
    const sitesInLastDay = this.containerTarget.lastElementChild
      .querySelector(".sites-list")
      .querySelectorAll(".site").length;

    if (sitesInLastDay) return;

    this.containerTarget.dataset.days = +this.containerTarget.dataset.days - 1;
    this.containerTarget.lastElementChild.remove();
    return this.trimDays();
  }

  toggleFav() {
    this.drawerTarget.classList.toggle("-translate-x-56");
    this.formTarget.classList.toggle("w-full");
    this.formTarget.classList.toggle("w-10/12");
  }
}
