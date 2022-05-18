class GoldenIdea::Good < ApplicationRecord
  has_many :exchange_records
  before_create :set_site

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def set_site
    self.site = Employee.current_employee.site
  end
end
