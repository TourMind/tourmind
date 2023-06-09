import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "controllers";
import "@hotwired/turbo-rails";

//FONTAWESOME
import "scripts";


Rails.start();
Turbolinks.start();
ActiveStorage.start();
import "../controllers";