class Plain < ApplicationRecord
  validates_presence_of :name
  has_many :plain_detail, dependent: :destroy
end
