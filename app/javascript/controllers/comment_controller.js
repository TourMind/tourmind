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
      window.location.hash = "comment-form"
    })
  }

  refreshCommentList() {
    fetch(this.data.get("comment-url"))
      .then(response => response.text())
      .then(html => {
        const commentListTarget = this.commentListTarget
        commentListTarget.innerHTML = html
        const commentForm = document.querySelector("#comment-form")
        commentForm.scrollIntoView({ behavior: 'smooth' })
      })
  }
}






