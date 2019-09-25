class AddIsScrapyToTempBookIsbns < ActiveRecord::Migration[5.1]
  def change
    add_column :temp_book_isbns, :is_scrapy,  :integer, limit: 1, default: 0, comment: "记录此isbn是否抓取"
  end
end
