class AddSiteToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :site, :string, limit: 30
  end
end
