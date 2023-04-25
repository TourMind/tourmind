import { application } from "./application";

import FlashController from "./flash_controller";
application.register("flash", FlashController);

import EditController from "./edit_controller";
application.register("edit", EditController);

import SortingController from "./sorting_controller";
application.register("sorting", SortingController);
