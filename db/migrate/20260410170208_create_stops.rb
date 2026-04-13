class CreateStops < ActiveRecord::Migration[8.1]
  def change
    create_table :stops, primary_key: :id, id: :integer do |t|
      t.integer :code
      t.string :name
      t.string :lat
      t.string :lon

      t.timestamps
    end
  end
end
