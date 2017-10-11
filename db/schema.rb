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

ActiveRecord::Schema.define(version: 20171011144249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "priority"
    t.integer  "preview_id"
    t.integer  "banner_id"
    t.boolean  "to_nav",           default: false
    t.integer  "preview_priority"
    t.index ["banner_id"], name: "index_categories_on_banner_id", using: :btree
    t.index ["preview_id"], name: "index_categories_on_preview_id", using: :btree
  end

  create_table "chain_types", force: :cascade do |t|
    t.string "title"
  end

  create_table "collections", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.integer  "priority"
  end

  create_table "incrustation_items", force: :cascade do |t|
    t.integer  "quantity"
    t.decimal  "weight"
    t.string   "purity"
    t.integer  "incrustation_id"
    t.integer  "product_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["incrustation_id"], name: "index_incrustation_items_on_incrustation_id", using: :btree
    t.index ["product_id"], name: "index_incrustation_items_on_product_id", using: :btree
  end

  create_table "incrustations", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kits", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "products_count"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.integer  "index_id"
    t.integer  "slide_id"
    t.index ["index_id"], name: "index_manufacturers_on_index_id", using: :btree
    t.index ["slide_id"], name: "index_manufacturers_on_slide_id", using: :btree
  end

  create_table "metal_colors", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metal_type_products", force: :cascade do |t|
    t.integer "metal_type_id"
    t.integer "product_id"
    t.index ["metal_type_id"], name: "index_metal_type_products_on_metal_type_id", using: :btree
    t.index ["product_id"], name: "index_metal_type_products_on_product_id", using: :btree
  end

  create_table "metal_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "product_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.index ["category_id"], name: "index_product_types_on_category_id", using: :btree
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
    t.integer  "priority"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.decimal  "new_price"
    t.integer  "collection_id"
    t.integer  "kit_id"
    t.integer  "sex",             default: 3
    t.integer  "category_id"
    t.integer  "manufacturer_id"
    t.decimal  "price_per_gramm"
    t.integer  "preview_id"
    t.boolean  "visible",         default: true
    t.boolean  "recommendation",  default: false
    t.boolean  "hit",             default: false
    t.integer  "chain_type_id"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["chain_type_id"], name: "index_products_on_chain_type_id", using: :btree
    t.index ["collection_id"], name: "index_products_on_collection_id", using: :btree
    t.index ["kit_id"], name: "index_products_on_kit_id", using: :btree
    t.index ["manufacturer_id"], name: "index_products_on_manufacturer_id", using: :btree
    t.index ["metal_color_id"], name: "index_products_on_metal_color_id", using: :btree
    t.index ["preview_id"], name: "index_products_on_preview_id", using: :btree
    t.index ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
    t.index ["sale_size_id"], name: "index_products_on_sale_size_id", using: :btree
  end

  create_table "products_promos", force: :cascade do |t|
    t.integer "product_id"
    t.integer "promo_id"
    t.index ["product_id"], name: "index_products_promos_on_product_id", using: :btree
    t.index ["promo_id"], name: "index_products_promos_on_promo_id", using: :btree
  end

  create_table "promos", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "picture_id"
    t.integer  "preview_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["picture_id"], name: "index_promos_on_picture_id", using: :btree
    t.index ["preview_id"], name: "index_promos_on_preview_id", using: :btree
  end

  create_table "sale_sizes", force: :cascade do |t|
    t.integer  "sale_percent"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "size_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "shop_id"
    t.integer  "size_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_size_items_on_product_id", using: :btree
    t.index ["shop_id"], name: "index_size_items_on_shop_id", using: :btree
    t.index ["size_id"], name: "index_size_items_on_size_id", using: :btree
  end

  create_table "sizes", force: :cascade do |t|
    t.string   "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slides", force: :cascade do |t|
    t.boolean "hide",       default: false
    t.string  "href"
    t.integer "priority"
    t.integer "picture_id"
    t.index ["picture_id"], name: "index_slides_on_picture_id", using: :btree
  end

  add_foreign_key "incrustation_items", "incrustations"
  add_foreign_key "incrustation_items", "products"
  add_foreign_key "metal_type_products", "metal_types"
  add_foreign_key "metal_type_products", "products"
  add_foreign_key "product_types", "categories"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "chain_types"
  add_foreign_key "products", "collections"
  add_foreign_key "products", "kits"
  add_foreign_key "products", "manufacturers"
  add_foreign_key "products", "metal_colors"
  add_foreign_key "products", "product_types"
  add_foreign_key "products", "sale_sizes"
  add_foreign_key "products_promos", "products"
  add_foreign_key "products_promos", "promos"
  add_foreign_key "size_items", "products"
  add_foreign_key "size_items", "shops"
  add_foreign_key "size_items", "sizes"
end
