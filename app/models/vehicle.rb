require 'google/transit/gtfs-realtime.pb'

class Vehicle
    attr_accessor :id, :trip_id, :route_id, :current_stop_sequence, :current_status, :timestamp, :stop_id, :lat, :lon, :bearing, :speed
    @@url = "https://bustime.ttc.ca/gtfsrt/vehicles"
    @@timestamp = 0
    @@vehicles = []

    STATUS_NAMES = {
        0 => 'incoming at',
        1 => 'in transit to',
        2 => 'stopped at'
    }.freeze

    def initialize(id, trip_id, route_id, current_stop_sequence, current_status, timestamp, stop_id, lat, lon, bearing, speed)
        @id = id
        @trip_id = trip_id
        @route_id = route_id
        @current_stop_sequence = current_stop_sequence
        @current_status = current_status
        @timestamp = timestamp
        @stop_id = stop_id
        @lat = lat.round(6)
        @lon = lon.round(6)
        @bearing = bearing.round(0)
        @speed = speed.round(1)
    end

    def to_s
        "#{self.id} is #{self.current_status} #{Stop.find_by(id: self.stop_id)&.name || 'no info'}, at #{self.speed} km/hr"
    end

    def self.on_route(route_id)
        vehicles = self.fetch_vehicles
        vehicles.select { |vehicle| vehicle.route_id == route_id.to_s }
    end


    def self.fetch_vehicles
        data = Net::HTTP.get(URI.parse(@@url))
        feed = Transit_realtime::FeedMessage.decode(data)
        if feed.header.timestamp <= @@timestamp
            return @@vehicles
        end
        @@vehicles.clear
        for entity in feed.entity do
            if entity.field?(:vehicle)
                info = entity.vehicle
                next unless info.field?(:trip)
                @@vehicles.push(Vehicle.new(info.vehicle.id, info.trip.trip_id, info.trip.route_id, info.current_stop_sequence, STATUS_NAMES[info.current_status], info.timestamp, info.stop_id, info.position.latitude, info.position.longitude, info.position.bearing, info.position.speed))
            end
        end
        @@vehicles
    end
end
