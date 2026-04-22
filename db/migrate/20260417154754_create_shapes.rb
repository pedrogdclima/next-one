class CreateShapes < ActiveRecord::Migration[8.1]
  def change
    create_table :shapes, id: false do |t|
      t.string :id, primary_key: true
      t.timestamps
    end
  end
end
