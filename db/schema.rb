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

ActiveRecord::Schema.define(version: 20170416214144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidate_election_districts", force: :cascade do |t|
    t.integer  "candidate_id"
    t.integer  "election_id"
    t.integer  "district_id"
    t.integer  "votes_total"
    t.float    "votes_percent"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["candidate_id"], name: "index_candidate_election_districts_on_candidate_id", using: :btree
    t.index ["district_id"], name: "index_candidate_election_districts_on_district_id", using: :btree
    t.index ["election_id"], name: "index_candidate_election_districts_on_election_id", using: :btree
  end

  create_table "candidates", force: :cascade do |t|
    t.string   "name"
    t.integer  "party_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party_id"], name: "index_candidates_on_party_id", using: :btree
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "election_districts", force: :cascade do |t|
    t.integer  "election_id"
    t.integer  "district_id"
    t.integer  "winner_id"
    t.integer  "voters_registered"
    t.integer  "total_votes"
    t.integer  "ballots_rejected"
    t.integer  "ballots_valid"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["district_id"], name: "index_election_districts_on_district_id", using: :btree
    t.index ["election_id"], name: "index_election_districts_on_election_id", using: :btree
    t.index ["winner_id"], name: "index_election_districts_on_winner_id", using: :btree
  end

  create_table "election_leaders", force: :cascade do |t|
    t.integer  "candidate_id"
    t.integer  "election_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["candidate_id"], name: "index_election_leaders_on_candidate_id", using: :btree
    t.index ["election_id"], name: "index_election_leaders_on_election_id", using: :btree
  end

  create_table "elections", force: :cascade do |t|
    t.integer  "year"
    t.integer  "premier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["premier_id"], name: "index_elections_on_premier_id", using: :btree
  end

  create_table "parties", force: :cascade do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "candidate_election_districts", "candidates"
  add_foreign_key "candidate_election_districts", "districts"
  add_foreign_key "candidate_election_districts", "elections"
  add_foreign_key "candidates", "parties"
  add_foreign_key "election_districts", "candidates", column: "winner_id"
  add_foreign_key "election_districts", "districts"
  add_foreign_key "election_districts", "elections"
  add_foreign_key "election_leaders", "candidates"
  add_foreign_key "election_leaders", "elections"
  add_foreign_key "elections", "candidates", column: "premier_id"
end
