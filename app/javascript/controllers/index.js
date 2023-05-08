// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName
import { application } from "./application";

import ChartController from "./chart_controller"
application.register("chart", ChartController)

import EditController from "./edit_controller"
application.register("edit", EditController)

import PictureController from "./picture_controller";
application.register("picture", PictureController);

import FilterController from "./filter_controller";
application.register("filter", FilterController);

import ButtController from "./butt_controller";
application.register("butt", ButtController);

import FlashController from "./flash_controller";
application.register("flash", FlashController);

import CommentController from "./comment_controller";
application.register("comment", CommentController);

import MapController from "./map_controller"
application.register("map", MapController)

import MovingController from "./moving_controller"
application.register("moving", MovingController)

import FavoriteController from "./favorite_controller";
application.register("favorite", FavoriteController);

import NavbarController from "./navbar_controller";
application.register("navbar", NavbarController);

import SortingController from "./sorting_controller"
application.register("sorting", SortingController)
