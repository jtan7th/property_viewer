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

  apply(event) {
    event.preventDefault()
    console.log("Apply method called")
    this.element.requestSubmit()
    this.close() // Optionally close the modal after applying filters
  }
}