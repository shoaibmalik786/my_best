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

ActiveRecord::Schema.define(version: 20131226180238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", primary_key: "category_id", force: true do |t|
    t.integer "parents"
    t.string  "en"
    t.string  "de"
    t.string  "es"
    t.string  "fr"
    t.string  "it"
    t.string  "jp"
    t.string  "kr"
    t.string  "zh"
    t.string  "zh_hant"
    t.string  "abstract"
  end

  create_table "categories_factual_to_mcc", id: false, force: true do |t|
    t.integer "mcc_code",                        null: false
    t.string  "mcc_label",           limit: 300
    t.integer "factual_category_id"
  end

  create_table "city", id: false, force: true do |t|
    t.integer "id",                           null: false
    t.integer "country_id",                   null: false
    t.string  "name",                         null: false
    t.float   "latitude"
    t.float   "longitude"
    t.string  "factual_id",        limit: 50
    t.string  "factual_parent_id", limit: 50
  end

  add_index "city", ["id"], name: "pk_city", unique: true, using: :btree
  add_index "city", ["name"], name: "idx_city_name", using: :btree

  create_table "country", id: false, force: true do |t|
    t.integer "id",                    null: false
    t.string  "code",       limit: 2,  null: false
    t.string  "name",                  null: false
    t.float   "latitude"
    t.float   "longitude"
    t.string  "factual_id", limit: 50
  end

  add_index "country", ["code"], name: "idx_country_code", using: :btree
  add_index "country", ["id"], name: "pk_country", unique: true, using: :btree
  add_index "country", ["name"], name: "idx_country_name", using: :btree

  create_table "error_log", id: false, force: true do |t|
    t.integer  "error_log_id",              limit: 8,   null: false
    t.string   "description",               limit: 500
    t.datetime "error_log_date"
    t.integer  "placescrawler_newadded_id", limit: 8
  end

  add_index "error_log", ["placescrawler_newadded_id"], name: "pk_error_log_0", unique: true, using: :btree

  create_table "hinge", id: false, force: true do |t|
    t.integer  "hid",                 limit: 8,   null: false
    t.string   "hid_name",            limit: 200
    t.integer  "added_by",            limit: 8,   null: false
    t.integer  "verified_by",         limit: 8
    t.datetime "hinge_add_date"
    t.datetime "hinge_approval_date"
  end

  add_index "hinge", ["added_by"], name: "idx_human_interests_engine", using: :btree
  add_index "hinge", ["verified_by"], name: "idx_human_interests_engine_0", using: :btree

  create_table "hinge_business_category", id: false, force: true do |t|
    t.integer  "mcc_code",                null: false
    t.integer  "hid",           limit: 8, null: false
    t.integer  "creator_id",    limit: 8
    t.integer  "approver_id",   limit: 8
    t.datetime "created_date"
    t.datetime "approval_date"
  end

  add_index "hinge_business_category", ["approver_id"], name: "idx_channels_0", using: :btree
  add_index "hinge_business_category", ["creator_id"], name: "idx_channels", using: :btree
  add_index "hinge_business_category", ["hid"], name: "idx_business_category_hid", using: :btree
  add_index "hinge_business_category", ["mcc_code"], name: "idx_business_category_hid_0", using: :btree

  create_table "hinge_message", id: false, force: true do |t|
    t.integer "message_id", limit: 8, null: false
    t.integer "hid",        limit: 8, null: false
  end

  add_index "hinge_message", ["hid"], name: "idx_channels_message", using: :btree
  add_index "hinge_message", ["message_id"], name: "idx_channels_message_0", using: :btree

  create_table "message", primary_key: "message_id", force: true do |t|
    t.integer  "user_id",             limit: 8
    t.integer  "profile_places_id",   limit: 8
    t.datetime "created_datetime"
    t.string   "message_image",       limit: 500
    t.string   "description",         limit: 500,                 null: false
    t.boolean  "isfacebookshare",                 default: true
    t.boolean  "isgoogleplusshare",               default: true
    t.boolean  "istwittershare"
    t.boolean  "is_sold_out",                     default: false
    t.boolean  "is_saved",                        default: false
    t.integer  "message_status_id"
    t.string   "message_type",        limit: 1,   default: "M"
    t.float    "lattitude"
    t.float    "longitude"
    t.integer  "places_id_execution", limit: 8
    t.integer  "action_button_id"
    t.datetime "crawl_insert_date"
    t.datetime "api_insert_date"
    t.string   "source_name"
    t.string   "source_url"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "frequency",           limit: 1
    t.integer  "message_source_id"
    t.time     "frequency_time"
  end

  add_index "message", ["action_button_id"], name: "idx_message_1", using: :btree
  add_index "message", ["message_source_id"], name: "idx_message_0", using: :btree
  add_index "message", ["message_status_id"], name: "idx_message_3", using: :btree
  add_index "message", ["places_id_execution"], name: "idx_message_2", using: :btree
  add_index "message", ["user_id"], name: "idx_message", using: :btree

  create_table "message_action", primary_key: "message_action_id", force: true do |t|
    t.string "description", limit: 50
  end

  create_table "message_action_configuration", id: false, force: true do |t|
    t.integer  "message_id",        limit: 8,                          null: false
    t.integer  "user_id",           limit: 8,                          null: false
    t.integer  "message_action_id",                                    null: false
    t.decimal  "price",                       precision: 12, scale: 2
    t.integer  "max_quantity"
    t.integer  "transaction_code",  limit: 8,                          null: false
    t.datetime "action_date_time",                                     null: false
  end

  add_index "message_action_configuration", ["message_action_id"], name: "idx_message_action_configuration_2", using: :btree
  add_index "message_action_configuration", ["message_id"], name: "idx_message_action_configuration_0", using: :btree
  add_index "message_action_configuration", ["user_id"], name: "idx_message_action_configuration_1", using: :btree

  create_table "message_analytics", primary_key: "messageanalytics_id", force: true do |t|
    t.integer  "message_id",      limit: 8,   null: false
    t.integer  "user_id",         limit: 8
    t.datetime "engagement_time"
    t.integer  "sharer_id",       limit: 8
    t.string   "shared_to"
    t.string   "ipaddress",       limit: 20
    t.string   "macaddress",      limit: 100
    t.string   "user_agent",      limit: 50
    t.string   "device",          limit: 50
    t.string   "facebookuser_id", limit: 50
    t.integer  "facebook_shares"
    t.integer  "googleplus"
    t.integer  "tweets"
    t.integer  "reach"
    t.integer  "frequency"
    t.integer  "impressions"
  end

  add_index "message_analytics", ["message_id"], name: "idx_message_analytics_0", using: :btree
  add_index "message_analytics", ["sharer_id"], name: "idx_message_analytics_1", using: :btree
  add_index "message_analytics", ["user_id"], name: "idx_message_analytics", using: :btree

  create_table "message_button", id: false, force: true do |t|
    t.integer "action_button_id", null: false
    t.integer "description"
  end

  create_table "message_button_configuration", id: false, force: true do |t|
    t.integer  "message_id"
    t.integer  "action_button_id"
    t.integer  "minimum_quantity"
    t.integer  "maximum_quantity"
    t.datetime "created_datetime"
    t.decimal  "cost",             precision: 12, scale: 2
  end

  add_index "message_button_configuration", ["action_button_id"], name: "idx_message_button_configuration", using: :btree

  create_table "message_curated", id: false, force: true do |t|
    t.integer  "message_id",              limit: 8,   null: false
    t.integer  "message_curated_code_id"
    t.integer  "user_id",                 limit: 8
    t.string   "comments",                limit: 500
    t.datetime "curated_time"
  end

  add_index "message_curated", ["message_curated_code_id"], name: "idx_message_curated", using: :btree
  add_index "message_curated", ["user_id"], name: "idx_message_curated_0", using: :btree

  create_table "message_curated_code", primary_key: "message_curatedcode_id", force: true do |t|
    t.string "description", limit: 100
  end

  create_table "message_curation", primary_key: "curation_id", force: true do |t|
    t.integer  "message_id",         limit: 8
    t.integer  "curator_id",         limit: 8
    t.datetime "curate_date"
    t.string   "comments",           limit: 200
    t.integer  "curation_status_id",             null: false
  end

  add_index "message_curation", ["curation_status_id"], name: "idx_message_curation", using: :btree
  add_index "message_curation", ["curator_id"], name: "idx_message_curation_1", using: :btree
  add_index "message_curation", ["message_id"], name: "idx_message_curation_0", using: :btree

  create_table "message_curation_status", id: false, force: true do |t|
    t.integer "curation_status_id",            null: false
    t.string  "status",             limit: 20
  end

  create_table "message_source", primary_key: "message_source_id", force: true do |t|
    t.string "messagesource_name", limit: 200, null: false
  end

  create_table "message_status", primary_key: "status_id", force: true do |t|
    t.string "status_description", limit: 30
  end

  create_table "places", primary_key: "place_id", force: true do |t|
    t.string   "factual_id",           limit: 36
    t.string   "name"
    t.string   "address"
    t.string   "address_extended"
    t.string   "locality"
    t.string   "region"
    t.string   "postcode"
    t.string   "country",              limit: 2
    t.text     "neighbourhood"
    t.string   "tel",                  limit: 20
    t.string   "fax",                  limit: 20
    t.string   "website"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "chain_name"
    t.string   "post_town"
    t.string   "chain_id",             limit: 36
    t.string   "admin_region"
    t.string   "po_box"
    t.text     "hours_display"
    t.string   "email"
    t.string   "email_sec"
    t.integer  "category_ids"
    t.string   "category_labels"
    t.integer  "claimedby",            limit: 8
    t.date     "claimedbydate"
    t.string   "business_description"
    t.string   "business_logo"
    t.boolean  "ismissing"
    t.integer  "added_by",             limit: 8
    t.datetime "date_added"
    t.integer  "verified_by",          limit: 8
    t.datetime "verified_date"
    t.boolean  "is_crawler",                      default: false
    t.boolean  "is_api",                          default: false
    t.boolean  "is_execution_place"
  end

  add_index "places", ["added_by"], name: "idx_places", using: :btree
  add_index "places", ["category_ids"], name: "idx_places_1", unique: true, using: :btree
  add_index "places", ["verified_by"], name: "idx_places_0", using: :btree

  create_table "places_category", id: false, force: true do |t|
    t.integer "id",                null: false
    t.string  "name",              null: false
    t.integer "parent_id"
    t.integer "factual_id"
    t.integer "factual_parent_id"
  end

  add_index "places_category", ["id"], name: "pk_places_category", unique: true, using: :btree

  create_table "places_polygon", id: false, force: true do |t|
    t.integer "root_place_id", limit: 8, null: false
    t.integer "node_place_id", limit: 8, null: false
  end

  add_index "places_polygon", ["node_place_id"], name: "idx_places_polygon_0", using: :btree
  add_index "places_polygon", ["root_place_id"], name: "idx_places_polygon", using: :btree

  create_table "places_profile", id: false, force: true do |t|
    t.integer  "places_id",            limit: 8,                   null: false
    t.integer  "user_id",              limit: 8
    t.string   "name"
    t.string   "time_zone"
    t.string   "image",                limit: 200
    t.integer  "business_type_code"
    t.string   "address_one"
    t.string   "address_two"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "zip_id"
    t.integer  "country_id"
    t.string   "bio"
    t.string   "contact",              limit: 200
    t.string   "email",                limit: 50
    t.string   "tel",                  limit: 20
    t.string   "website",              limit: 200
    t.datetime "created_date"
    t.boolean  "isfacebookpersonal",               default: false
    t.boolean  "isgooglepluspersonal",             default: false
    t.boolean  "istwitterpersonal",                default: false
  end

  add_index "places_profile", ["city_id"], name: "idx_places_profile_1", using: :btree
  add_index "places_profile", ["country_id"], name: "idx_places_profile_0", using: :btree
  add_index "places_profile", ["state_id"], name: "idx_places_profile", using: :btree
  add_index "places_profile", ["user_id"], name: "pk_places_profile", using: :btree
  add_index "places_profile", ["zip_id"], name: "idx_places_profile_2", using: :btree

  create_table "places_profile_categories", id: false, force: true do |t|
    t.integer "places_id",          limit: 8, null: false
    t.integer "places_category_id",           null: false
    t.integer "category_type",                null: false
  end

  add_index "places_profile_categories", ["category_type"], name: "idx_places_profile_categories_type", using: :btree

  create_table "places_profile_facebook", id: false, force: true do |t|
    t.integer  "places_id",  limit: 8, null: false
    t.string   "uid"
    t.boolean  "enabled"
    t.string   "image"
    t.string   "profile"
    t.string   "gender"
    t.string   "birthday"
    t.string   "locale"
    t.string   "location"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "web"
  end

  add_index "places_profile_facebook", ["uid"], name: "idx_places_profile_facebook_on_uid", unique: true, using: :btree

  create_table "places_profile_franchise", id: false, force: true do |t|
    t.integer  "franchise_id",      limit: 8, null: false
    t.integer  "places_id",         limit: 8, null: false
    t.datetime "added_datetime"
    t.integer  "added_by",          limit: 8
    t.integer  "verified_by",       limit: 8
    t.datetime "verification_date"
  end

  add_index "places_profile_franchise", ["places_id"], name: "idx_places_profile_franchise", using: :btree

  create_table "places_profile_google", id: false, force: true do |t|
    t.integer  "place_id",   limit: 8, null: false
    t.string   "uid"
    t.boolean  "enabled"
    t.string   "image"
    t.string   "profile"
    t.string   "gender"
    t.string   "birthday"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "web"
  end

  add_index "places_profile_google", ["uid"], name: "idx_places_profile_google_on_uid", unique: true, using: :btree

  create_table "places_profile_operating_hours", id: false, force: true do |t|
    t.integer "places_id", limit: 8, null: false
  end

  create_table "places_profile_twitter", id: false, force: true do |t|
    t.integer  "place_id",    limit: 8, null: false
    t.string   "uid"
    t.boolean  "enabled"
    t.string   "image"
    t.string   "location"
    t.boolean  "geo_enabled"
    t.string   "time_zone"
    t.string   "utc_offset"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "web"
  end

  add_index "places_profile_twitter", ["uid"], name: "idx_places_profile_twitter_on_uid", unique: true, using: :btree

  create_table "sessions_histories", force: true do |t|
    t.string   "ip"
    t.string   "header"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "state", id: false, force: true do |t|
    t.integer "id",                           null: false
    t.integer "country_id",                   null: false
    t.string  "name",                         null: false
    t.float   "latitude"
    t.float   "longitude"
    t.string  "factual_id",        limit: 50
    t.string  "factual_parent_id", limit: 50
  end

  add_index "state", ["id"], name: "pk_state", unique: true, using: :btree
  add_index "state", ["name"], name: "idx_state_name", using: :btree

  create_table "subscription_email_list_ingest", id: false, force: true do |t|
    t.integer  "ingest_id",     limit: 8,   null: false
    t.integer  "place_id",      limit: 8
    t.string   "email_address", limit: 200
    t.datetime "ingest_date"
    t.string   "frist_name",    limit: 50
    t.string   "last_name",     limit: 50
    t.string   "middle_name",   limit: 50
  end

  add_index "subscription_email_list_ingest", ["ingest_id"], name: "idx_subscription_email_list_ingest_0", using: :btree
  add_index "subscription_email_list_ingest", ["place_id"], name: "idx_subscription_email_list_ingest", using: :btree

  create_table "subscription_email_list_ingest_name", id: false, force: true do |t|
    t.integer "ingest_id",   limit: 8,   null: false
    t.string  "ingest_name", limit: 100
  end

  create_table "subscription_hinge", id: false, force: true do |t|
    t.integer  "hid",               limit: 8, null: false
    t.integer  "user_id",           limit: 8, null: false
    t.datetime "subscription_date"
  end

  add_index "subscription_hinge", ["hid"], name: "idx_subscription_human_interests", using: :btree
  add_index "subscription_hinge", ["user_id"], name: "idx_subscription_human_interests_0", using: :btree

  create_table "subscription_places", id: false, force: true do |t|
    t.integer  "place_id",          limit: 8, null: false
    t.integer  "user_id",           limit: 8, null: false
    t.datetime "subscription_date"
  end

  add_index "subscription_places", ["place_id"], name: "idx_subscription_places_0", using: :btree
  add_index "subscription_places", ["user_id"], name: "idx_subscription_places", using: :btree

  create_table "user_activity", id: false, force: true do |t|
    t.integer  "user_activity_id", limit: 8,  null: false
    t.integer  "user_id",          limit: 8
    t.integer  "other_user",       limit: 8
    t.integer  "activity_type_id"
    t.datetime "activity_date"
    t.integer  "message_id",       limit: 8
    t.string   "narrative",        limit: 50
  end

  add_index "user_activity", ["activity_type_id"], name: "idx_user_activity_1", using: :btree
  add_index "user_activity", ["message_id"], name: "idx_user_activity_2", using: :btree
  add_index "user_activity", ["other_user"], name: "idx_user_activity_0", using: :btree
  add_index "user_activity", ["user_id"], name: "idx_user_activity", using: :btree

  create_table "user_activity_type", id: false, force: true do |t|
    t.integer "activity_type_id",            null: false
    t.string  "activity",         limit: 30
  end

  create_table "user_address", primary_key: "address_id", force: true do |t|
    t.integer "user_id",     limit: 8
    t.string  "alias_name",  limit: 100
    t.integer "city_id"
    t.integer "state_id"
    t.integer "zipcode_id"
    t.integer "country_id"
    t.float   "longitude"
    t.float   "latitude"
    t.string  "address_one"
    t.string  "address_two"
    t.float   "lat"
    t.float   "lng"
    t.boolean "main",                    default: false
  end

  add_index "user_address", ["city_id"], name: "idx_user_address_3", using: :btree
  add_index "user_address", ["country_id"], name: "idx_user_address_1", using: :btree
  add_index "user_address", ["state_id"], name: "idx_user_address_0", using: :btree
  add_index "user_address", ["user_id"], name: "idx_user_address", using: :btree
  add_index "user_address", ["zipcode_id"], name: "idx_user_address_2", using: :btree

  create_table "user_authenticate", id: false, force: true do |t|
    t.integer "user_id",  limit: 8,  null: false
    t.string  "pass",     limit: 40, null: false
    t.boolean "is_reset"
  end

  create_table "user_info", primary_key: "user_id", force: true do |t|
    t.string   "first_name",             limit: 50
    t.string   "middle_name",            limit: 100
    t.string   "last_name",              limit: 50
    t.string   "gender",                 limit: 1
    t.datetime "date_of_birth"
    t.datetime "created"
    t.boolean  "verified"
    t.string   "photo",                  limit: 200
    t.integer  "mobile_number",          limit: 8
    t.string   "time_zone",              limit: 100
    t.string   "web"
    t.string   "phone",                  limit: 50
    t.string   "bio",                    limit: 200
    t.boolean  "is_facebook",                        default: false
    t.boolean  "is_google",                          default: false
    t.boolean  "is_twitter",                         default: false
    t.boolean  "is_private",                         default: false
    t.string   "email",                  limit: 50
    t.string   "encrypted_password",                 default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                    default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "user_info", ["confirmation_token"], name: "idx_user_info_on_confirmation_token", unique: true, using: :btree
  add_index "user_info", ["email"], name: "idx_user_info_on_email", unique: true, using: :btree
  add_index "user_info", ["reset_password_token"], name: "idx_user_info_on_reset_password_token", unique: true, using: :btree
  add_index "user_info", ["unlock_token"], name: "idx_user_info_on_unlock_token", unique: true, using: :btree

  create_table "user_info_facebook", id: false, force: true do |t|
    t.integer  "user_id",    limit: 8, null: false
    t.string   "uid",                  null: false
    t.string   "image"
    t.string   "profile"
    t.string   "gender"
    t.string   "birthday"
    t.string   "locale"
    t.string   "location"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_info_facebook", ["uid"], name: "idx_facebook_user_info_on_uid", unique: true, using: :btree

  create_table "user_info_google", id: false, force: true do |t|
    t.integer  "user_id",    limit: 8, null: false
    t.string   "uid",                  null: false
    t.string   "image"
    t.string   "profile"
    t.string   "gender"
    t.string   "birthday"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_info_google", ["uid"], name: "idx_google_user_info_on_uid", unique: true, using: :btree

  create_table "user_info_twitter", id: false, force: true do |t|
    t.integer  "user_id",     limit: 8,                 null: false
    t.string   "uid",                                   null: false
    t.string   "image"
    t.string   "location"
    t.boolean  "geo_enabled",           default: false
    t.string   "time_zone"
    t.string   "utc_offset"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_info_twitter", ["uid"], name: "idx_twitter_user_info_on_uid", unique: true, using: :btree

  create_table "user_log", id: false, force: true do |t|
    t.integer  "log_id",      limit: 8,   null: false
    t.integer  "user_id",     limit: 8
    t.integer  "log_type_id"
    t.string   "description", limit: 300
    t.string   "device",      limit: 200
    t.string   "user_agent",  limit: 200
    t.string   "ipaddress",   limit: 16
    t.string   "macaddress",  limit: 50
    t.datetime "logdate"
  end

  add_index "user_log", ["log_type_id"], name: "idx_user_log_0", using: :btree
  add_index "user_log", ["user_id"], name: "idx_user_log", using: :btree

  create_table "user_log_action", id: false, force: true do |t|
    t.integer "log_type_id",            null: false
    t.string  "description", limit: 20
  end

  create_table "user_notifications_email", id: false, force: true do |t|
    t.integer "userid",   limit: 8, null: false
    t.boolean "email"
    t.boolean "mentions"
    t.boolean "new_mail"
  end

  create_table "user_notifications_mobile", id: false, force: true do |t|
    t.integer "user_id",              limit: 8, null: false
    t.boolean "mobile"
    t.boolean "all_friends_activity"
    t.boolean "mentions_me"
    t.boolean "new_notifications"
  end

  create_table "user_roles", id: false, force: true do |t|
    t.integer "role_id",             null: false
    t.string  "rolename", limit: 50
  end

  create_table "user_roles_assignment", id: false, force: true do |t|
    t.integer "role_id",            null: false
    t.integer "user_id",  limit: 8, null: false
    t.integer "place_id", limit: 8, null: false
  end

  add_index "user_roles_assignment", ["place_id"], name: "idx_user_roles_assignment_0", using: :btree
  add_index "user_roles_assignment", ["role_id"], name: "idx_user_roles_assignment_1", using: :btree
  add_index "user_roles_assignment", ["user_id"], name: "idx_user_roles_assignment", using: :btree

  create_table "username", force: true do |t|
    t.string   "username",   limit: 50, null: false
    t.integer  "user_id",    limit: 8
    t.integer  "places_id",  limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "username", ["places_id"], name: "idx_username_on_business_id", using: :btree
  add_index "username", ["user_id"], name: "idx_username_on_user_id", using: :btree
  add_index "username", ["username"], name: "idx_username_on_username", unique: true, using: :btree

  create_table "zip_code", id: false, force: true do |t|
    t.integer "id",                           null: false
    t.integer "country_id",                   null: false
    t.string  "name",                         null: false
    t.float   "latitude"
    t.float   "longitude"
    t.string  "factual_id",        limit: 50
    t.string  "factual_parent_id", limit: 50
  end

  add_index "zip_code", ["id"], name: "pk_zip_code", unique: true, using: :btree
  add_index "zip_code", ["name"], name: "idx_zip_code_name", using: :btree

end
