class Brand < ApplicationRecord
  validates_uniqueness_of :BrandName
  validates_presence_of :BrandName
  has_many :series, dependent: :destroy
end
