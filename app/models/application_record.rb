class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  has_many :attachments, as: :attachable, dependent: :destroy


end
