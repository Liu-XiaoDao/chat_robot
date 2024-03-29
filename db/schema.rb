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

ActiveRecord::Schema.define(version: 20220719094412) do

  create_table "attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "attachment"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.string "attachable_type"
    t.integer "attachable_id"
    t.text "notes"
    t.string "attachment_file_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blorgh_articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_classifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.string "intro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.string "author"
    t.text "intro"
    t.string "img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "book_classification_id"
    t.integer "is_borrowed", default: 0
    t.integer "borrower_id"
    t.integer "praise_count", default: 0
    t.integer "rubbish_count", default: 0
    t.string "yk_code", limit: 20
    t.string "isbn", limit: 20
    t.string "douban_url"
    t.string "info"
    t.string "img_path"
  end

  create_table "borrow_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "book_id"
    t.integer "employee_id"
    t.date "borrow_start"
    t.date "borrow_end"
    t.string "borrow_range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "real_borrow_time"
    t.string "note"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "employee_id"
    t.string "body"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_comments_on_book_id"
  end

  create_table "count_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "ip"
    t.string "count_type"
    t.bigint "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "target_class"
    t.integer "employee_id"
    t.index ["target_id"], name: "index_count_records_on_target_id"
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.integer "parentid"
    t.integer "leaderid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "position"
    t.integer "department_id"
    t.string "unionid"
    t.string "userid"
    t.string "dingid"
    t.string "name"
    t.boolean "isleader"
    t.boolean "active"
    t.boolean "isadmin"
    t.string "openid"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "extension_number"
    t.string "linear_telephone"
    t.date "hired_date"
    t.integer "is_leave", limit: 1, default: 0, comment: "记录员工是否离职,已离职:1,未离职:0"
    t.decimal "credits", precision: 8, scale: 3
    t.decimal "score", precision: 8, scale: 3, default: "0.0"
    t.decimal "available_score", precision: 8, scale: 3, default: "0.0"
    t.string "email", limit: 50
    t.string "site", limit: 30
  end

  create_table "expresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "employee_id"
    t.string "express_type"
    t.boolean "is_send_noti"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "golden_idea_assign_score_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "employee_id"
    t.integer "idea_id"
    t.decimal "score", precision: 8, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "site", limit: 50
  end

  create_table "golden_idea_exchange_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "good_id"
    t.bigint "employee_id"
    t.decimal "used_score", precision: 8, scale: 3
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "site", limit: 50
    t.index ["employee_id"], name: "index_golden_idea_exchange_records_on_employee_id"
    t.index ["good_id"], name: "index_golden_idea_exchange_records_on_good_id"
  end

  create_table "golden_idea_goods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.string "description"
    t.integer "quantity"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "score"
    t.string "site", limit: 50
  end

  create_table "golden_idea_ideas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.string "description"
    t.string "department"
    t.string "category"
    t.string "status"
    t.text "content"
    t.string "proposer"
    t.bigint "season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "score", precision: 8, scale: 1
    t.integer "reporter_id"
    t.integer "is_involve_sop"
    t.string "sop_file_path"
    t.integer "origin_season_id"
    t.string "site", limit: 50
    t.index ["season_id"], name: "index_golden_idea_ideas_on_season_id"
  end

  create_table "golden_idea_score_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "employee_id"
    t.integer "idea_id"
    t.decimal "score", precision: 8, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "benefit", precision: 8, scale: 3
    t.decimal "cost", precision: 8, scale: 3
    t.decimal "risk", precision: 8, scale: 3
    t.string "site", limit: 50
  end

  create_table "golden_idea_seasons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "collecter"
    t.string "site", limit: 50
  end

  create_table "golden_idea_suggests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "employee_id"
    t.text "content"
    t.integer "suggest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "site", limit: 50
    t.string "title", limit: 150
    t.integer "real_name"
    t.string "status", limit: 20
  end

  create_table "links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.text "url_link"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "display_order"
    t.boolean "is_able", default: true
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "target_type"
    t.integer "target_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.string "author"
    t.integer "view_count", default: 0
    t.integer "praise_count", default: 0
    t.integer "rubbish_count", default: 0
    t.integer "is_check", default: 0
    t.text "content_html"
  end

  create_table "request_stats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "path"
    t.integer "count"
    t.text "params_stats"
    t.float "max_time", limit: 24
    t.float "min_time", limit: 24
    t.float "avg_time", limit: 24
    t.datetime "last_requested_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "return_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "book_id"
    t.integer "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "note"
  end

  create_table "temp_book_isbns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "isbn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "is_scrapy", limit: 1, default: 0, comment: "记录此isbn是否抓取"
  end

  create_table "user_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "request_stat_id"
    t.string "url"
    t.float "time", limit: 24
    t.integer "memory_usage"
    t.string "path"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remote_ip"
    t.integer "employee_id"
  end

  add_foreign_key "comments", "books"
end
