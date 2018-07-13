class Employee < ApplicationRecord

  belongs_to :department, foreign_key: :department, optional: true
  # has_many :consumablerecords
  # has_many :attached_files, ->{ where( attached_files: { target_class: "authorizationservices" } ) }, :foreign_key => :target_id
  def department_name
    department.try(:name)
  end
end
