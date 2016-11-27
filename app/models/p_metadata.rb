class PMetadata < ApplicationRecord
  has_one :qr_image, dependent: :destroy

  def qr_image
    QrImage.where("p_metadata_id = #{self[:id]}").map{|i|  i.image.url }.first
  end

end
