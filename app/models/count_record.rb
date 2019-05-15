class CountRecord < ApplicationRecord
  belongs_to :employee, optional: true

end
