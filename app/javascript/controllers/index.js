import { application } from "./application"

import FlashController from "./flash_controller"
application.register("flash", FlashController)
import MovingController from "./moving_controller"
application.register("moving", MovingController)

import PictureController from "./picture_controller"
application.register("picture", PictureController)


