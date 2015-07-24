# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150722105058) do

  create_table "image_msts", force: :cascade do |t|
    t.string   "filename"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "vector_size"
  end

  create_table "keyword_ignores", force: :cascade do |t|
    t.integer  "image_mst_id"
    t.integer  "keyword_mst_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "keyword_msts", force: :cascade do |t|
    t.string   "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keyword_stores", force: :cascade do |t|
    t.integer  "image_mst_id"
    t.integer  "keyword_mst_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "similar_images", id: false, force: :cascade do |t|
    t.integer  "image_id_src"
    t.integer  "image_id_tgt"
    t.float    "inner_product"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "similar_images", ["image_id_src", "image_id_tgt"], name: "index_similar_images_on_image_id_src_and_image_id_tgt", unique: true

end
