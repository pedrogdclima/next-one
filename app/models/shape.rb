class Shape < ApplicationRecord
    has_many :points
    has_many :trips
    self.primary_key = :id

    def self.for_vehicles(vehicles)
        trip_ids = vehicles.map{|vehicle| vehicle.trip_id}
        # Remove trip_ids from vehicles with schedule_relationship: added
        trip_ids.delete_if {|id| id.starts_with?('-')}
        shape_ids = Trip.find(trip_ids).map{|trip| trip.shape_id}.uniq
        self.find(shape_ids).map{|shape| shape.points.map{|point| [point.lat, point.lon]}}
    end
end
