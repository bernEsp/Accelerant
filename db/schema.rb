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

ActiveRecord::Schema.define(:version => 20101026135838) do

  create_table "admins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sortable"
    t.integer  "groupable"
  end

  create_table "attribute_tags", :force => true do |t|
    t.string   "field_1"
    t.string   "field_2"
    t.string   "field_3"
    t.string   "field_4"
    t.string   "field_5"
    t.string   "field_6"
    t.string   "field_7"
    t.string   "field_8"
    t.string   "field_9"
    t.string   "field_10"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attributes", :force => true do |t|
    t.string   "field_1"
    t.string   "field_2"
    t.string   "field_3"
    t.string   "field_4"
    t.string   "field_5"
    t.string   "field_6"
    t.string   "field_7"
    t.string   "field_8"
    t.string   "field_9"
    t.string   "field_10"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comment_assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "discussion_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "comment"
    t.string   "upload"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignment_id"
    t.binary   "data",                :limit => 1048576
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "project_id"
    t.integer  "discussion_id"
    t.boolean  "hide_until_answered",                    :default => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip",        :limit => 20
    t.string   "country",    :limit => 2,  :default => "US"
    t.string   "phone",      :limit => 20
    t.string   "fax",        :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussions", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.integer  "character_minimum",  :default => 0
    t.integer  "sortable"
    t.integer  "groupable"
  end

  create_table "email_parsers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follow_ups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "reply_id"
    t.integer  "reply_belongs_to"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read"
  end

  create_table "groupableitems", :force => true do |t|
    t.text     "description"
    t.integer  "groupables"
    t.integer  "position"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groupables", :force => true do |t|
    t.text     "title"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groupabletargets", :force => true do |t|
    t.text     "description"
    t.integer  "groupable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moderators", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "one_to_one",         :default => false
    t.boolean  "response_box",       :default => true
    t.integer  "moderator_id"
    t.integer  "theme",              :default => 1
    t.boolean  "lock",               :default => false
    t.boolean  "active",             :default => true
  end

  create_table "replies", :force => true do |t|
    t.text     "content"
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.boolean  "private",            :default => false
    t.integer  "discussion_id"
  end

  create_table "reponses", :force => true do |t|
    t.text     "content"
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sortableitems", :force => true do |t|
    t.text     "description"
    t.integer  "sortables"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "sortables", :force => true do |t|
    t.text     "title"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_comments", :force => true do |t|
    t.text     "content"
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcomments", :force => true do |t|
    t.text     "content"
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "themes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "color",             :default => "07395a"
  end

  create_table "user_assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "user_images", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "primary"
    t.datetime "created_at"
    t.string   "filename"
    t.string   "path"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "parent_id"
    t.string   "thumbnail"
  end

  create_table "usergroupables", :force => true do |t|
    t.integer  "groupable"
    t.integer  "groupableitem"
    t.integer  "user"
    t.integer  "position"
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
    t.boolean  "admin",                                    :default => false
    t.boolean  "participant",                              :default => false
    t.boolean  "client",                                   :default => false
    t.boolean  "moderator",                                :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "company_id",                               :default => 0
    t.string   "field_1"
    t.string   "field_2"
    t.string   "field_3"
    t.string   "field_4"
    t.string   "field_5"
    t.string   "field_6"
    t.string   "field_7"
    t.string   "field_8"
    t.string   "field_9"
    t.string   "field_10"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "usersortables", :force => true do |t|
    t.integer  "sortable"
    t.integer  "sortableitem"
    t.integer  "user"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "participant",  :default => false
  end

  create_table "wysihat_files", :force => true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
