class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips, id: false do |t|
      t.string :id, primary_key: true
      t.integer :route_id
      t.integer :service_id
      t.string :headsign
      t.string :short_name
      t.integer :direction_id
      t.belongs_to :shape, type: :string

      t.timestamps
    end
  end
end
