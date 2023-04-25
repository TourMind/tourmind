import { Controller } from "@hotwired/stimulus";
import { Loader } from "@googlemaps/js-api-loader";

// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["map", "day"];

  async connect() {
    const loader = new Loader({
      apiKey: "",
      version: "weekly",
    });

    await loader.load();

    const locArr = [];
    const nameArr = [];

    const locationCoordinates = this.dayTarget
      .querySelectorAll(".site")
      .forEach((el) => {
        locArr.push({ lat: +el.dataset.lat, lng: +el.dataset.lng });
        nameArr.push(el.dataset.name);
      });

    const locLat = locArr.map((el) => el.lat).sort((a, b) => a - b);
    const locLng = locArr.map((el) => el.lng).sort((a, b) => a - b);

    const center = {
      lat: locLat[0] + (locLat[locLat.length - 1] - locLat[0]) / 2,
      lng: locLng[0] + (locLng[locLng.length - 1] - locLng[0]) / 2,
    };

    const map = new google.maps.Map(this.mapTarget, {
      center,
      zoom: 11,
    });

    locArr.forEach((loc, i) => {
      new google.maps.Marker({
        position: loc,
        map,
      });
    });
  }
}
