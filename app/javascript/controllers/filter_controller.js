import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal" ]

  connect() {
    console.log("Filter controller connected")
  }

  open(event) {
    event.preventDefault()
    console.log("Open method called")
    this.modalTarget.classList.remove('hidden')
  }

  close() {
    console.log("Close method called")
    this.modalTarget.classList.add('hidden')
  }
}