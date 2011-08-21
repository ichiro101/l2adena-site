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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110821073859) do

  create_table "forum_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.integer  "forum_category_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_servers", :force => true do |t|
    t.string   "name"
    t.string   "gameserver_hostname"
    t.string   "gameserver_port"
    t.string   "gameserver_database_hostname"
    t.string   "gameserver_database_port"
    t.string   "gameserver_database_username"
    t.string   "gameserver_database_password"
    t.string   "gameserver_database_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible"
    t.integer  "position"
  end

  create_table "news", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.text     "content"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "permalink"
    t.string   "name"
    t.text     "content"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible"
  end

  create_table "permission_roles", :force => true do |t|
    t.integer  "permission_id", :null => false
    t.integer  "role_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "nickname"
    t.string   "website"
    t.text     "profile_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_replies", :force => true do |t|
    t.integer  "user_id",                 :null => false
    t.integer  "ticket_id",               :null => false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_status_change_id"
  end

  add_index "ticket_replies", ["ticket_id"], :name => "index_ticket_replies_on_ticket_id"
  add_index "ticket_replies", ["ticket_status_change_id"], :name => "index_ticket_replies_on_ticket_status_change_id"
  add_index "ticket_replies", ["user_id"], :name => "index_ticket_replies_on_user_id"

  create_table "ticket_status_changes", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.integer  "ticket_id",     :null => false
    t.integer  "status_change", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ticket_status_changes", ["ticket_id"], :name => "index_ticket_status_changes_on_ticket_id"
  add_index "ticket_status_changes", ["user_id"], :name => "index_ticket_status_changes_on_user_id"

  create_table "tickets", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "content"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "forum_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_game_accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "hashed_password", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
