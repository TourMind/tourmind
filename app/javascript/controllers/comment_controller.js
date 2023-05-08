import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  static targets = ["form", "commentList"]

  submitForm(event) {
    event.preventDefault()
    const form = this.formTarget

    fetch(form.action, {
      method: form.method,
      body: new FormData(form)
    }).then(() => {
      // 成功提交表單後要做的事情
      form.reset()
      this.refreshCommentList()
      window.scrollTo(0, window.scrollY)
    })
  }

  refreshCommentList() {
    fetch(this.data.get("comment-url"))
      .then(response => response.text())
      .then(html => {
        this.commentListTarget.innerHTML = html
        this.commentListTarget.scrollIntoView(false);
      })
  }
}


