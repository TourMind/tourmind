import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

// Connects to data-controller="sorting"
export default class extends Controller {
  connect() {
    if (this.element.id === "fav-list") {
      return this.favList(this.element);
    }

    if (this.element.classList.contains("sites-list")) {
      return this.siteList(this.element);
    }

    if (this.element.id === "delete-btn") {
      return this.deleteBtn(this.element);
    }
  }

  favList(element) {
    new Sortable(element, {
      group: {
        name: "shared",
        pull: "clone",
        put: false,
      },
      animation: 150,
      sort: false,
      onClone: function (e) {
        e.clone.id = e.item.id;
      },
    });
  }

  siteList(element) {
    new Sortable(element, {
      group: "shared",
      animation: 150,
      ghostClass: "opacity-0",
    });
  }

  deleteBtn(element) {
    new Sortable(element, {
      group: "shared",
      animation: 150,
      ghostClass: "hidden",
      onAdd: (e) => {
        e.target.querySelector(".site").remove();
      },
    });
  }
}
