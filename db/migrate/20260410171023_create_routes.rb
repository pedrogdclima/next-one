class CreateRoutes < ActiveRecord::Migration[8.1]
  def change
    create_table :routes, primary_key: :id, id: :integer do |t|
      t.string :short_name
      t.string :long_name
      t.string :mode_type

      t.timestamps
    end
  end
end
