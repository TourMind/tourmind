import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "section", "showAll", "showFew"]
  
  toggle(event) {
    event.preventDefault()
    const sectionName = event.target.dataset.section
    this.sectionTargets.forEach(section => {
      if (section.dataset.section === sectionName || sectionName == "all") {
        section.classList.remove('hidden')
      } else {
        section.classList.add('hidden')
      }
    })
  }
  // toggleShow(event) {
  //   event.preventDefault()
  //   this.sectionTargets.forEach(section => {
  //   })
  // }
}