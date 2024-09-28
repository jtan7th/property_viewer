import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import "@hotwired/turbo"
import "./carousel"
import "./modal"
import { setupModalHandler } from "./modal_handler"
import { Slideover } from "tailwindcss-stimulus-components"
import "./slideover"



const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("turbo:load", function() {
  setupModalHandler();
});
