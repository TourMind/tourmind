import { application } from "./application"

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import FavoriteController from "./favorite_controller";
application.register("favorite", FavoriteController)