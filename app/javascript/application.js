import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import  "@hotwired/turbo"
import "./carousel"
import "./modal"
console.log(Turbo)
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("turbo:load", function() {
  console.log("Turbo is loaded!");
});

document.addEventListener("turbo:before-fetch-request", function(event) {
  console.log("Turbo fetch request:", event.detail.fetchOptions.headers);
});

document.addEventListener("turbo:before-fetch-response", function(event) {
  console.log("Turbo fetch response:", event.detail.fetchResponse);
});
