import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "section" ]

  connect() {
    console.log("test")
  }
  
  toggle(event) {
    event.preventDefault()
    const sectionName = event.target.dataset.section
    console.log(sectionName)
    this.sectionTargets.forEach(section => {
      console.log(section)
      if (section.dataset.section === sectionName) {
        section.classList.remove('hidden')
      } else {
        section.classList.add('hidden')
      }
    })
  }
}