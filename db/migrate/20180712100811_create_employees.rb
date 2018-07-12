class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string  :position
      t.integer :department
      t.string  :unionid
      t.string  :userid
      t.string  :dingid
      t.string  :name
      t.boolean :isleader
      t.boolean :active
      t.boolean :isadmin
      t.string  :openid
      t.string  :avatar
      t.timestamps
    end
  end
end
