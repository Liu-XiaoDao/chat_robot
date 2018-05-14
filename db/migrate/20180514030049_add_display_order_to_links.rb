class AddDisplayOrderToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :display_order, :integer
  end
end
