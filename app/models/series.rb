class Series < ApplicationRecord
  validates_presence_of :SeriesName
  has_many :detail, dependent: :destroy
  belongs_to :brand
  has_one :series_background_image, dependent: :destroy

  def series_background_image
    SeriesBackgroundImage.where("series_id = #{self[:id]}").map{|i|  i.image.url }.first
  end
end
