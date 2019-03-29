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

ActiveRecord::Schema.define(version: 20190328100438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_categories_on_ancestry", using: :btree
  end

  create_table "commission_factory_categories", force: :cascade do |t|
    t.integer  "category_id",                    null: false
    t.integer  "commission_factory_importer_id", null: false
    t.string   "query"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["category_id"], name: "index_commission_factory_categories_on_category_id", using: :btree
    t.index ["commission_factory_importer_id"], name: "index_commission_factory_categories_on_commission_factory_id", using: :btree
  end

  create_table "commission_factory_importers", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "csv_file_name"
    t.string   "csv_content_type"
    t.integer  "csv_file_size"
    t.datetime "csv_updated_at"
    t.index ["user_id"], name: "index_commission_factory_importers_on_user_id", using: :btree
  end

  create_table "crawl_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "product_crawler_id"
    t.string   "url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "viglink_category"
    t.index ["category_id"], name: "index_crawl_categories_on_category_id", using: :btree
    t.index ["product_crawler_id"], name: "index_crawl_categories_on_product_crawler_id", using: :btree
  end

  create_table "cropped_products", force: :cascade do |t|
    t.integer  "image_of_interest_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["image_of_interest_id"], name: "index_cropped_products_on_image_of_interest_id", using: :btree
  end

  create_table "detected_products", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "image_of_interest_id"
    t.json     "product_coordinate"
    t.index ["image_of_interest_id"], name: "index_detected_products_on_image_of_interest_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "image_of_interests", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
    t.string   "uuid",               null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["user_id"], name: "index_image_of_interests_on_user_id", using: :btree
    t.index ["uuid"], name: "index_image_of_interests_on_uuid", using: :btree
  end

  create_table "liked_products", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_liked_products_on_product_id", using: :btree
    t.index ["user_id"], name: "index_liked_products_on_user_id", using: :btree
  end

  create_table "product_crawlers", force: :cascade do |t|
    t.string   "location"
    t.string   "title_css"
    t.string   "price_css"
    t.string   "description_css"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id"
    t.string   "image_css"
    t.string   "image_attribute"
    t.string   "image_regex"
    t.string   "base_url"
    t.boolean  "js",               default: false
    t.string   "strip_css"
    t.string   "product_link_css"
    t.string   "load_more_css"
    t.boolean  "paginated",        default: false
    t.boolean  "viglink",          default: false
    t.index ["location"], name: "index_product_crawlers_on_location", using: :btree
    t.index ["user_id"], name: "index_product_crawlers_on_user_id", using: :btree
    t.index ["viglink"], name: "index_product_crawlers_on_viglink", using: :btree
  end

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "product_image_file_name"
    t.string   "product_image_content_type"
    t.integer  "product_image_file_size"
    t.datetime "product_image_updated_at"
    t.string   "direct_url"
    t.integer  "position",                   default: 0
    t.string   "cropped_image_file_name"
    t.string   "cropped_image_content_type"
    t.integer  "cropped_image_file_size"
    t.datetime "cropped_image_updated_at"
    t.index ["position"], name: "index_product_images_on_position", using: :btree
    t.index ["product_id"], name: "index_product_images_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "user_id"
    t.integer  "price_in_cents"
    t.string   "location"
    t.string   "redirect_url"
    t.integer  "product_crawler_id"
    t.string   "uuid",                                           null: false
    t.boolean  "crawled",                        default: false
    t.integer  "commission_factory_category_id"
    t.index ["commission_factory_category_id"], name: "index_products_on_commission_factory_category_id", using: :btree
    t.index ["crawled"], name: "index_products_on_crawled", using: :btree
    t.index ["product_crawler_id"], name: "index_products_on_product_crawler_id", using: :btree
    t.index ["user_id", "created_at"], name: "index_products_on_user_id_and_created_at", using: :btree
    t.index ["user_id"], name: "index_products_on_user_id", using: :btree
  end

  create_table "proxies", force: :cascade do |t|
    t.string   "ip"
    t.string   "port"
    t.string   "user"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "user_agent"
  end

  create_table "user_categories", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id", using: :btree
    t.index ["user_id"], name: "index_user_categories_on_user_id", using: :btree
  end

  create_table "user_category_products", force: :cascade do |t|
    t.integer  "user_category_id"
    t.integer  "product_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["product_id"], name: "index_user_category_products_on_product_id", using: :btree
    t.index ["user_category_id"], name: "index_user_category_products_on_user_category_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "header_image_file_name"
    t.string   "header_image_content_type"
    t.integer  "header_image_file_size"
    t.datetime "header_image_updated_at"
    t.text     "description"
    t.datetime "date_of_birth"
    t.string   "instagram_token"
    t.string   "country"
    t.string   "slug"
    t.string   "instagram_username"
    t.string   "website_url"
    t.string   "payment_gateway_token"
    t.integer  "roles_mask"
    t.string   "uuid"
    t.datetime "confirmation_sent_at"
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.json     "tokens"
    t.string   "provider",                  default: "email", null: false
    t.string   "uid"
    t.boolean  "set_up_completed",          default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "commission_factory_categories", "categories"
  add_foreign_key "commission_factory_categories", "commission_factory_importers"
  add_foreign_key "commission_factory_importers", "users"
  add_foreign_key "crawl_categories", "categories"
  add_foreign_key "crawl_categories", "product_crawlers"
  add_foreign_key "cropped_products", "image_of_interests"
  add_foreign_key "image_of_interests", "users"
  add_foreign_key "liked_products", "products"
  add_foreign_key "liked_products", "users"
  add_foreign_key "product_crawlers", "users"
  add_foreign_key "products", "commission_factory_categories"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
  add_foreign_key "user_category_products", "products"
  add_foreign_key "user_category_products", "user_categories"
end
