import { application } from "./application";

import FlashController from "./flash_controller";
application.register("flash", FlashController);

import EditController from "./edit_controller";
application.register("edit", EditController);

import MapController from "./map_controller";
application.register("map", MapController);

import SortingController from "./sorting_controller";
application.register("sorting", SortingController);

import MovingController from "./moving_controller";
application.register("moving", MovingController);

import PictureController from "./picture_controller";
application.register("picture", PictureController);

import HotelController from "./hotel_controller";
application.register("hotel", HotelController);

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import FavoriteController from "./favorite_controller";
application.register("favorite", FavoriteController)
