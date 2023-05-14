import { Controller } from "@hotwired/stimulus"
import * as Turbo from "@hotwired/turbo"


export default class extends Controller {
  connect() {
    this.element.addEventListener('turbo:submit-end', function (event){
        if (event.detail.success) {
            Turbo.visit(window.location.href)
        }
    })
  }
}