class CreateCountRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :count_records do |t|
      t.string 'ip'    #访问者的ip
      t.string 'type'  #三种赞，踩，查看那
      t.references 'question'
      t.timestamps
    end
  end
end
