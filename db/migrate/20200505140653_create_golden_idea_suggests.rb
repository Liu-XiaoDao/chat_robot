class CreateGoldenIdeaSuggests < ActiveRecord::Migration[5.1]
  def change
    create_table :golden_idea_suggests do |t|
      t.integer :employee_id
      t.text :content
      t.integer :suggest_id
      t.timestamps
    end
  end
end
