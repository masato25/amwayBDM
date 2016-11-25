class Series < ApplicationRecord
  validates_presence_of :SeriesName
  has_many :detail, dependent: :destroy
  belongs_to :brand
end
