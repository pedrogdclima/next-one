# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_20_183220) do
  create_table "points", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "dist_travelled"
    t.decimal "lat"
    t.decimal "lon"
    t.decimal "sequence"
    t.string "shape_id"
    t.datetime "updated_at", null: false
    t.index ["shape_id"], name: "index_points_on_shape_id"
  end

  create_table "routes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "long_name"
    t.string "mode_type"
    t.string "short_name"
    t.datetime "updated_at", null: false
  end

  create_table "shapes", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stops", force: :cascade do |t|
    t.integer "code"
    t.datetime "created_at", null: false
    t.string "lat"
    t.string "lon"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "trips", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "direction_id"
    t.string "headsign"
    t.integer "route_id"
    t.integer "service_id"
    t.string "shape_id"
    t.string "short_name"
    t.datetime "updated_at", null: false
    t.index ["shape_id"], name: "index_trips_on_shape_id"
  end
end
