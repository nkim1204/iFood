# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100311024922) do

  create_table "ingredient_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.integer  "ingredient_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_comments", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_ingredients", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.float    "qty"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_instructions", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "step_num"
    t.text     "instruction_text"
    t.string   "instruction_photo_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_ratings", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", :force => true do |t|
    t.integer  "user_id"
    t.string   "recipe_photo_path"
    t.boolean  "approved"
    t.text     "overview"
    t.float    "prep_time"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_ingredients", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ingredient_id"
    t.float    "qty"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.boolean  "is_admin",                                 :default => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
