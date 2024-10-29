// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import Turbo from "@hotwired/turbo"
eagerLoadControllersFrom("controllers", application)

// Manually register mobile menu controller
import MobileMenuController from "./mobile_menu_controller.js"
application.register("mobile-menu", MobileMenuController)
