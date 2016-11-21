class Series < ApplicationRecord
  validates_uniqueness_of :SeriesName
  validates_presence_of :SeriesName
  validates_format_of :TitleColor, :with => /#\d+/
  has_many :detail, dependent: :destroy
  belongs_to :brand
end
