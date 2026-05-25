# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "leaflet", to: "https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
pin "leaflet-rotatedmarker", to: "https://unpkg.com/leaflet-rotatedmarker@0.2.0/leaflet.rotatedMarker.js"
