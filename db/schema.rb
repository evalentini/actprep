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

ActiveRecord::Schema.define(:version => 20140217015625) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "selected_ans"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "timetaken"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "tutor_id"
    t.integer  "student_id"
    t.boolean  "pending"
    t.boolean  "approved"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "homeworks", :force => true do |t|
    t.string   "name"
    t.date     "due"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "user_id"
    t.boolean  "quiz",       :default => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "test_number"
    t.string   "section"
    t.integer  "question_number"
    t.text     "question_text"
    t.integer  "num_ans_choices"
    t.integer  "correct_ans"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.text     "ans_choice_1"
    t.text     "ans_choice_2"
    t.text     "ans_choice_3"
    t.text     "ans_choice_4"
    t.text     "ans_choice_5"
    t.integer  "page"
    t.text     "explanation"
    t.string   "explanation_image_file_name"
    t.string   "explanation_image_content_type"
    t.integer  "explanation_image_file_size"
    t.datetime "explanation_image_updated_at"
    t.integer  "homework_id"
  end

  create_table "quizscores", :force => true do |t|
    t.integer  "homework_id"
    t.integer  "student_id"
    t.datetime "completed"
    t.integer  "num_question"
    t.integer  "num_right"
    t.float    "cum_time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "homework_id"
    t.integer  "student_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "role"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "locked"
    t.boolean  "omniauth_user"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "firstname",          :default => "none"
    t.string   "lastname",           :default => "none"
    t.string   "usertype",           :default => "student"
  end

end
