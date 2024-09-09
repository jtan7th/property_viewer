import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // static targets = ["frame"]

  // open(event) {
  //   event.preventDefault()
  //   const url = event.currentTarget.getAttribute("href")
  //   const frame = document.getElementById("modal")
  //   frame.src = url
  //   frame.style.display = "block"
  // }

  // close() {
  //   const frame = document.getElementById("modal")
  //   frame.style.display = "none"
  //   frame.src = ""
  // }

  static targets = ["panel"]

  connect() {
    setTimeout(() => this.showModal(), 50)
  }

  hideModal() {
    this.panelTarget.classList.remove("opacity-100", "translate-y-0", "sm:scale-100")
    this.panelTarget.classList.add("opacity-0", "translate-y-4", "sm:translate-y-0", "sm:scale-95")
  }

  showModal() {
    this.panelTarget.classList.remove("opacity-0", "translate-y-4", "sm:translate-y-0", "sm:scale-95")
    this.panelTarget.classList.add("opacity-100", "translate-y-0", "sm:scale-100")
  }
}