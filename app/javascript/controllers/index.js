import { application } from "./application"

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)