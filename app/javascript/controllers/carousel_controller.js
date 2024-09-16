import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image"]

  connect() {
    console.log("Carousel controller connected")
    this.currentIndex = 0
    this.showCurrentImage()
  }

  next() {
    this.currentIndex = (this.currentIndex + 1) % this.imageTargets.length
    this.showCurrentImage()
  }

  prev() {
    this.currentIndex = (this.currentIndex - 1 + this.imageTargets.length) % this.imageTargets.length
    this.showCurrentImage()
  }

  showCurrentImage() {
    this.imageTargets.forEach((image, index) => {
      image.classList.toggle('hidden', index !== this.currentIndex)
    })
  }
}