import { Controller } from "@hotwired/stimulus";
import { Loader } from "@googlemaps/js-api-loader";

// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["googleMap"];

  async connect() {
    const loader = new Loader({
      apiKey: "",
      version: "weekly",
    });

    await loader.load();

    const center = { lat: 25.11180425836727, lng: 121.5374090821731 };

    const map = new google.maps.Map(this.googleMapTarget, {
      center,
      zoom: 15,
    });

    const marker = new google.maps.Marker({
      position: center,
      map,
    });
  }
}
