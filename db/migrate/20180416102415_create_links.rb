class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string 'title'
      t.text   'url_link'
      t.string 'icon'
      t.timestamps
    end
  end
end
