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

ActiveRecord::Schema.define(version: 20_210_521_015_431) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'answers', force: :cascade do |t|
    t.bigint 'question_id', null: false
    t.boolean 'correct', default: false, null: false
    t.string 'body', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['question_id'], name: 'index_answers_on_question_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'title', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'questions', force: :cascade do |t|
    t.bigint 'test_id', null: false
    t.text 'body', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['test_id'], name: 'index_questions_on_test_id'
  end

  create_table 'tests', force: :cascade do |t|
    t.bigint 'category_id', null: false
    t.integer 'author', null: false
    t.integer 'level', default: 0, null: false
    t.string 'title', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['category_id'], name: 'index_tests_on_category_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'login', null: false
    t.string 'password', null: false
    t.string 'e_mail', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'answers', 'questions'
  add_foreign_key 'questions', 'tests'
  add_foreign_key 'tests', 'categories'
end
