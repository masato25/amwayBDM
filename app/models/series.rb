class Series < ApplicationRecord
  validates_presence_of :SeriesName
  validates_format_of :TitleColor, :with => /#\S+/
  has_many :detail, dependent: :destroy
  belongs_to :brand
end
