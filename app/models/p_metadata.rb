class PMetadata < ApplicationRecord
  has_one :qr_image, dependent: :destroy
end
