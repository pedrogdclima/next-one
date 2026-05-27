namespace :static_data do
    desc "Add all TTC Routes"
    task add_routes: :environment do
        routes_to_insert = []
        CSV.foreach(File.join(Rails.root, "data", "schedule", "routes.txt"), headers: true) do |row|
            routes_to_insert << {
                id: row["route_id"],
                short_name: row["route_short_name"],
                long_name: row["route_long_name"],
                mode_type: row["route_type"]
            }
        end
        Route.insert_all(routes_to_insert)
    end

    desc "Add all TTC Stops"
    task add_stops: :environment do
        stops_to_insert = []
        CSV.foreach(File.join(Rails.root, "data", "schedule", "stops.txt"), headers: true) do |row|
            stops_to_insert << {
                id: row["stop_id"],
                code: row["stop_code"],
                name: row["stop_name"],
                lat: row["stop_lat"],
                lon: row["stop_lon"]
            }
            if stops_to_insert.size >= 5000
                Stop.insert_all(stops_to_insert)
                stops_to_insert.clear
            end
        end
        Stop.insert_all(stops_to_insert) if stops_to_insert.any?
    end

    desc "Add all TTC Shapes"
    task add_shapes: :environment do
        existing_shapes = Set.new(Shape.pluck(:id))
        points_to_insert = []

        CSV.foreach(File.join(Rails.root, "data", "schedule", "shapes.txt"), headers: true) do |row|
            shape_id = row["shape_id"]
            unless existing_shapes.include?(shape_id)
                Shape.create! id: shape_id
                existing_shapes.add(shape_id)
            end

            points_to_insert << {
                shape_id: shape_id,
                lat: row["shape_pt_lat"],
                lon: row["shape_pt_lon"],
                sequence: row["shape_pt_sequence"],
                dist_travelled: row["shape_dist_traveled"]
            }

            if points_to_insert.size >= 5000
                Point.insert_all(points_to_insert)
                points_to_insert.clear
            end
        end

        Point.insert_all(points_to_insert) if points_to_insert.any?
    end

    desc "Add all TTC Trips"
    task add_trips: :environment do
        trips_to_insert = []
        CSV.foreach(File.join(Rails.root, "data", "schedule", "trips.txt"), headers: true) do |row|
            trips_to_insert << {
                id: row["trip_id"],
                route_id: row["route_id"],
                service_id: row["service_id"],
                headsign: row["trip_headsign"],
                direction_id: row["direction_id"],
                shape_id: row["shape_id"]
            }

            if trips_to_insert.size >= 5000
                Trip.insert_all(trips_to_insert)
                trips_to_insert.clear
            end
        end
        Trip.insert_all(trips_to_insert) if trips_to_insert.any?
    end

    desc "Drop all TTC Schedule data"
    task destroy_all: :environment do
        Point.delete_all
        Shape.delete_all
        Stop.delete_all
        Route.delete_all
        Trip.delete_all
    end

    desc "Add all TTC Schedule data"
    task add_all: :environment do
        [ "routes", "stops", "shapes", "trips" ].each do |data_name|
            task_name = "static_data:add_#{data_name}"
            puts "Starting #{task_name}"
            Rake::Task[task_name].execute
            puts "Completed #{task_name}"
        end
        puts "Completed all tasks"
    end
end
