class Series < ApplicationRecord
  # validates_uniqueness_of :SeriesName
  validates_presence_of :SeriesName
  has_many :detail, dependent: :destroy
  belongs_to :brand
  has_one :series_background_image, dependent: :destroy
  validates_length_of :SeriesName, :maximum => 9, :allow_blank => false

  def series_background_image
    SeriesBackgroundImage.where("series_id = #{self[:id]}").map{|i|  i.image.url }.first
  end
end
