class CompositionImage < ApplicationRecord
  belongs_to :detail
  has_attached_file :image,
                    :styles => {
                      :original =>  "960*1080>"
                    }
  validates_attachment_content_type :image,
    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"],
    size: { in: 03..1000.kilobytes }
  # validates_uniqueness_of :detail_id
end
