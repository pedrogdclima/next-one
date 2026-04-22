class CreatePoints < ActiveRecord::Migration[8.1]
  def change
    create_table :points do |t|
      t.decimal :lat
      t.decimal :lon
      t.decimal :sequence
      t.decimal :dist_travelled
      t.belongs_to :shape, index: true, type: :string

      t.timestamps
    end
  end
end
