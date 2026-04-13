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
end
