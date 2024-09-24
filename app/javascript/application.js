import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import "@hotwired/turbo"
import "./carousel"
import "./modal"
import { setupModalHandler } from "./modal_handler"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("turbo:load", function() {
  setupModalHandler();
});
