import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.initializeMap()
  }

  disconnect() {
    if (this.map) {
      this.map.remove()
      this.map = null
    }
  }

  initializeMap() {
    // Clean up any existing map
    if (this.map) {
      this.map.remove()
    }

    this.map = L.map(this.element).setView([43.6468, -79.3748], 12.48)
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(this.map)

    // Add vehicle markers
    const vehicles = JSON.parse(this.element.dataset.vehicles || '[]')
    vehicles.forEach((vehicle) => {
      L.marker(vehicle).addTo(this.map)
    })

    // Add route polyline
    const shapes = JSON.parse(this.element.dataset.shapes || '[]')
    if (shapes.length > 0) {
      let polyline = L.polyline(shapes, { color: 'red' }).addTo(this.map)
      this.map.fitBounds(polyline.getBounds())
    }
  }
}
