class AddPraiseRubbishToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :praise_count,  :integer, default: 0
    add_column :books, :rubbish_count, :integer, default: 0
  end
end
