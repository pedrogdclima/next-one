namespace :schedule do
    desc "Description of what the task does"
    task my_task: :environment do
        # Your Ruby code here
    end

    desc "Test task"
    task :test do
        puts "This is a test!"
        # puts :environment
    end

    desc "Fetch all TTC Stops"
    task stops: :environment do
        CSV.foreach(File.join(Rails.root, 'data', 'schedule', 'stops.txt'), headers: true) do |row|
            Stop.new(id: row['stop_id'], code: row['stop_code'], name: row['stop_name'], lat: row['stop_lat'], lon: row['stop_lon']).save
        end
    end

    desc "Fetch all TTC Routes"
    task routes: :environment do
        CSV.foreach(File.join(Rails.root, 'data', 'schedule', 'routes.txt'), headers: true) do |row|
            Route.new(id: row['route_id'], short_name: row['route_short_name'], long_name: row['route_long_name'], mode_type: row['route_type']).save
        end
    end

    desc "Fetch all TTC Shapes"
    task shapes: :environment do
        CSV.foreach(File.join(Rails.root, 'data', 'schedule', 'shapes.txt'), headers: true) do |row|
            # Shape.find_or_create_by! id: row['shape_id']
            Point.new(shape_id: row['shape_id'], lat: row['shape_pt_lat'], lon: row['shape_pt_lon'], sequence: row['shape_pt_sequence'], dist_travelled: row['shape_dist_traveled']).save
        end
    end

    desc "Fetch all TTC Trips"
    task trips: :environment do
        CSV.foreach(File.join(Rails.root, 'data', 'schedule', 'trips.txt'), headers: true) do |row|
            Trip.new(id: row['trip_id'], route_id: row['route_id'], service_id: row['service_id'], headsign: row['trip_headsign'], direction_id: row['direction_id'], shape_id: row['shape_id']).save
        end
    end
end
