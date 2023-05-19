import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="alert"
export default class extends Controller {
  connect() {
    Swal.fire('Title...', '沒有找到符合條件的飯店', 'warning')
  }
}
