class Attachment < ApplicationRecord
  has_attached_file :attachment, preserve_files: true

  do_not_validate_attachment_file_type :attachment

  belongs_to :attachable, polymorphic: true


  def name
    attachment_file_name
  end

  def image?
    attachment_content_type.match('image')
  end

  # FIXED: used in notification view
  def target_class
    attachable.try(:stage)
  end

end
