class QrImage < ApplicationRecord
  has_attached_file :image
  validates_attachment_content_type :image,
    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"],
    size: { in: 03..500.kilobytes }
  validates_uniqueness_of :metadata_id
end
