import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
    static targets = ["navbarMenu"]
    connect(){
      
    }
    toggleNavbarMenu() {
        this.navbarMenuTarget.classList.toggle('hidden');
    }
}