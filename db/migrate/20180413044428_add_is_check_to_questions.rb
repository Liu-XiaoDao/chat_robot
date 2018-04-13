class AddIsCheckToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :is_check, :integer
  end
end
