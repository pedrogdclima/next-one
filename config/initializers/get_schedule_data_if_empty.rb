if Rails.env.production?
    Thread.new do
        begin
            sleep(10)
            if Route.count == 0
                system("rake static_data:add_all")
            end
        rescue => e
            puts "Error: #{e.message}"
        end
    end
end
