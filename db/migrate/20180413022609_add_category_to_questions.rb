class AddCategoryToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :category_id, :integer
    add_column :questions, :author, :string
    add_column :questions, :view_count, :integer
    add_column :questions, :praise_count, :integer
    add_column :questions, :rubbish_count, :integer
  end
end
