class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string "attachment"
      t.string "attachment_file_name"
      t.string "attachment_content_type"
      t.string "attachable_type"
      t.integer "attachable_id"
      t.text "notes"
      t.string "attachment_file_size"
      t.timestamps
    end
  end
end
