class AddContentHtmlToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :content_html, :text
  end
end
