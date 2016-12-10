class CompositionImage < ApplicationRecord
  belongs_to :detail
  has_attached_file :image,
                    :styles => {
                      :original =>  "850x500>"
                    }
  validates_attachment_content_type :image,
    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"],
    size: { in: 03..500.kilobytes }
  validates_uniqueness_of :detail_id
end
