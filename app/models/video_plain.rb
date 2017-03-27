class VideoPlain < ApplicationRecord
  validates :name, uniqueness: true
  has_many :vp2_vd_maps, :dependent => :destroy
end
