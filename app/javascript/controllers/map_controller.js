import { Controller } from "@hotwired/stimulus";
import { Loader } from "@googlemaps/js-api-loader";

// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["map", "day"];

  async connect() {
    const loader = new Loader({
      apiKey: this.dayTarget.dataset.key,
      version: "weekly",
    });

    await loader.load();
    const directionsService = new google.maps.DirectionsService();
    const directionsRenderer = new google.maps.DirectionsRenderer({
      suppressMarkers: true,
    });

    const locArr = [];
    const nameArr = [];

    this.dayTarget.querySelectorAll(".site").forEach((el) => {
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
      zoom: 12,
    });

    directionsRenderer.setMap(map);

    const waypoints = locArr.slice(1, -1).map((el) => {
      return { location: el, stopover: true };
    });

    const req = {
      origin: locArr[0],
      destination: locArr[locArr.length - 1],
      waypoints,
      travelMode: "DRIVING",
    };

    directionsService.route(req, function (res, status) {
      if (status == "OK") {
        directionsRenderer.setDirections(res);
      }
    });

    locArr.forEach((loc, i) => {
      const contentString = nameArr[i];

      const infowindow = new google.maps.InfoWindow({
        content: contentString,
      });

      const marker = new google.maps.Marker({
        position: loc,
        map,
      });

      marker.addListener("click", () => {
        infowindow.open({
          anchor: marker,
          map,
        });
      });
    });
  }
}
