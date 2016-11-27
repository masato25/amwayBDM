class Machine < ApplicationRecord
  belongs_to :plain, optional: true
end
