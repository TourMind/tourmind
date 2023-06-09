import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["filterMenu", "filterCheckbox", "filterSubmitBtn"]

  connect() {
    if (document.documentElement.clientWidth > 1024) {
      this.registerCheckboxEvent(this.filterCheckboxTargets);
    }
  }

  //控制小於768px時出現的篩選鍵
  toggleFilterMenu() {
    this.filterMenuTarget.classList.toggle('hidden');
    this.filterMenuTarget.classList.toggle('overflow-auto');
    this.filterMenuTarget.style.height = `${window.innerHeight}px`
    document.body.classList.toggle('overflow-hidden');
  }

  //控制畫面左方分類區箭頭展開鍵
  toggleFilterCategory(event) {

    const icon = event.currentTarget.children[0];
    const filterOptions = event.currentTarget.nextElementSibling;

    icon.classList.toggle('rotate-180');
    filterOptions.classList.toggle('max-h-full');
  }

  registerCheckboxEvent(targets) {
    targets.map(target => {
      target.addEventListener('change', () => {
        this.filterSubmitBtnTarget.click()
      })
    })
  }

  removeTag(event) {
    const tagName = event.currentTarget.getAttribute('data-tag-name')
    const colName = event.currentTarget.getAttribute('data-col-name')
    const tagsParam = new URLSearchParams(window.location.search).getAll(colName + '[]')
    const updatedTagsParam = tagsParam.filter(tag => tag !== tagName)
    const urlParams = new URLSearchParams(window.location.search)
    urlParams.delete(colName + '[]')
    updatedTagsParam.forEach(tag => {
      urlParams.append(colName + '[]', tag)
    })
    const url = `${window.location.pathname}?${urlParams.toString()}`
    window.location.replace(url)
  }
}




