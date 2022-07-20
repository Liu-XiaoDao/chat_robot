class AddTitleRealNameToGoldenIdeaSuggests < ActiveRecord::Migration[5.1]
  def change
    add_column :golden_idea_suggests, :title, :string, limit:150
    add_column :golden_idea_suggests, :real_name, :integer
    add_column :golden_idea_suggests, :status, :string, limit:20
  end
end
