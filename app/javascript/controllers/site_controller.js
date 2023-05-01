import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="site"
export default class extends Controller {
    static targets = ["filterMenu", "filterCheckbox", "filterSubmitBtn"]

    connect() {
        this.registerCheckboxEvent(this.filterCheckboxTargets);
    }

    //控制小於768px時出現的篩選鍵
    toggleFilterMenu() {
        this.filterMenuTarget.classList.toggle('hidden');
    }

    //控制畫面左方分類區箭頭展開鍵
    toggleFilterCategory(event) {

        const icon = event.currentTarget.children[0];
        const filterOptions = event.currentTarget.nextElementSibling;

        icon.classList.toggle('rotate-180');
        filterOptions.classList.toggle('max-h-96');
    }

    registerCheckboxEvent(targets) {
        targets.map(target => {
            target.addEventListener('change', () => {
                this.filterSubmitBtnTarget.click()
            })
        })
    }
}