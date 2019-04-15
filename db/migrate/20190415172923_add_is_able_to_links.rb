class AddIsAbleToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :is_able, :boolean, default: true
  end
end
