import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame"]

  open(event) {
    event.preventDefault()
    const url = event.currentTarget.getAttribute("href")
    const frame = document.getElementById("modal")
    frame.src = url
    frame.style.display = "block"
  }

  close() {
    const frame = document.getElementById("modal")
    frame.style.display = "none"
    frame.src = ""
  }
}