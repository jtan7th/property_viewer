import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import "@hotwired/turbo"
import "./carousel"
import "./modal"
import "./slideover"
import "./range_slider"
import "./discrete_range_slider"
import "./mobile_menu"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }