class Detail < ApplicationRecord
  has_many :p_metadata, dependent: :destroy
  has_many :detail_image, dependent: :destroy
  has_one :feature_image, dependent: :destroy
  has_one :composition_image, dependent: :destroy
  has_one :qr_image, dependent: :destroy
  has_many :plain_detail, dependent: :destroy
  belongs_to :series, -> { select(:id, :seriesName, :brand_id) }, class_name: 'Series'
  delegate :brands, :to => :series
  validates_length_of :DetailName, :maximum => 30, :allow_blank => false
  validates_length_of :Feature, :maximum => 500, :allow_blank => true
  validates_presence_of :DetailName
  validates :series_id, presence: true
  validates_uniqueness_of :series_id, :scope => [:DetailName]

  def series_name
    Series.find(self["series_id"])["SeriesName"]
  end

  def brand_name
    series = Series.find(self["series_id"])
    Brand.find(series["brand_id"])["BrandName"]
  end

  def detail_images
    DetailImage.where("detail_id = #{self[:id]}").map{|i| i.image.url }
  end

  def feature_images
    FeatureImage.where("detail_id = #{self[:id]}").map{|i| i.image.url }.first
  end

  def composition_images
    CompositionImage.where("detail_id = #{self[:id]}").map{|i| i.image.url }
  end

  def qr_image
    QrImage.where("detail_id = #{self[:id]}").map{|i|  i.image.url }.first
  end

  def content_image
    ContentImage.where("detail_id = #{self[:id]}").map{|i|  i.image.url }.first
  end


  def p_metadata
    PMetadata.where("detail_id = #{self[:id]}")
  end

  def number_pmeta
    PMetadata.where("detail_id = #{self["id"]}").size
  end
end
