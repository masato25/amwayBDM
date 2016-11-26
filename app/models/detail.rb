class Detail < ApplicationRecord
  validates_presence_of :DetailName
  has_many :p_metadata, dependent: :destroy
  has_many :detail_image, dependent: :destroy
  has_one :feature_image, dependent: :destroy
  has_one :composition_image, dependent: :destroy
  has_many :plain_detail, dependent: :destroy
  belongs_to :series, -> { select(:id, :seriesName, :brand_id) }, class_name: 'Series'
  delegate :brands, :to => :series

  def series_name
    Series.find(self["series_id"])["SeriesName"]
  end

  def brand_name
    series = Series.find(self["series_id"])
    Brand.find(series["brand_id"])["BrandName"]
  end

  def number_pmeta
    PMetadata.where("detail_id = #{self["id"]}").size
  end
end
