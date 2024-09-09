import { Application } from "@hotwired/stimulus"
import  "@hotwired/turbo"
console.log(Turbo)
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
