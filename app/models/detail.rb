class Detail < ApplicationRecord
  validates_presence_of :DetailName
  has_many :p_metadata, dependent: :destroy
  has_many :detail_image, dependent: :destroy
  has_one :feature_image, dependent: :destroy
  has_one :composition_image, dependent: :destroy
  belongs_to :series, -> { select(:id, :seriesName) }, class_name: 'Series'
end
