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
    const directionsService = new google.maps.DirectionsService();
    const directionsRenderer = new google.maps.DirectionsRenderer();

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
      zoom: 11,
    });
    // directionsRenderer.setMap(map);

    // const waypoints = locArr.map((el, i, arr) => {
    //   if (i === 0 || i === arr.length - 1) return;
    //   return { location: el, stopover: true };
    // });

    // const req = {
    //   origin: locArr[0],
    //   destination: locArr[locArr.length - 1],
    //   waypoints,
    //   travelMode: "DRIVING",
    //   drivingOptions: {
    //     departureTime: Date.now(),
    //     trafficModel: "optimistic",
    //   },
    // };

    // directionsService.route(req, function (res, status) {
    //   if (status == "OK") {
    //     directionsRenderer.setDirections(res);
    //   }
    // });

    locArr.forEach((loc, i) => {
      const contentString = `<div id="content"><h3>${nameArr[i]}</h3></div>`;

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
