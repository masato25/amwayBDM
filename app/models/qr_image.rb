class QrImage < ApplicationRecord
  belongs_to :detail
  has_attached_file :image,
                    :styles => {
                      :original =>  "150x150>"
                    }
  # validates_attachment :image, dimensions: { height: 150, width: 150 }
  validates_attachment_content_type :image,
    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"],
    size: { in: 03..500.kilobytes }
  validates_uniqueness_of :detail_id
end
