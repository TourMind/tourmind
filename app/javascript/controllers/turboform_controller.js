import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('turbo:submit-end', function (event){
        if (event.detail.success) {
            const modal = document.querySelector("#modal")
            modal.classList.add("hidden")
            Turbo.visit(window.location.href)
        }
    })
  }
}