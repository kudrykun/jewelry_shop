# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170703235727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "incrustations", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incrustations_products", force: :cascade do |t|
    t.integer "incrustation_id"
    t.integer "product_id"
    t.index ["incrustation_id"], name: "index_incrustations_products_on_incrustation_id", using: :btree
    t.index ["product_id"], name: "index_incrustations_products_on_product_id", using: :btree
  end

  create_table "metal_colors", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metal_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metal_types_products", force: :cascade do |t|
    t.integer "metal_type_id"
    t.integer "product_id"
    t.index ["metal_type_id"], name: "index_metal_types_products_on_metal_type_id", using: :btree
    t.index ["product_id"], name: "index_metal_types_products_on_product_id", using: :btree
  end

  create_table "product_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.string   "artikul"
    t.decimal  "price"
    t.integer  "metal_color_id"
    t.decimal  "weight"
    t.integer  "product_type_id"
    t.integer  "sale_size_id"
    t.boolean  "to_main_page"
    t.string   "manufacturer"
    t.integer  "priority"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.decimal  "old_price"
    t.index ["metal_color_id"], name: "index_products_on_metal_color_id", using: :btree
    t.index ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
    t.index ["sale_size_id"], name: "index_products_on_sale_size_id", using: :btree
  end

  create_table "products_sizes", force: :cascade do |t|
    t.integer "size_id"
    t.integer "product_id"
    t.index ["product_id"], name: "index_products_sizes_on_product_id", using: :btree
    t.index ["size_id"], name: "index_products_sizes_on_size_id", using: :btree
  end

  create_table "sale_sizes", force: :cascade do |t|
    t.decimal  "sale_percent"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sizes", force: :cascade do |t|
    t.string   "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "incrustations_products", "incrustations"
  add_foreign_key "incrustations_products", "products"
  add_foreign_key "metal_types_products", "metal_types"
  add_foreign_key "metal_types_products", "products"
  add_foreign_key "products", "metal_colors"
  add_foreign_key "products", "product_types"
  add_foreign_key "products", "sale_sizes"
  add_foreign_key "products_sizes", "products"
  add_foreign_key "products_sizes", "sizes"
end
