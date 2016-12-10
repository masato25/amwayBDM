class DetailImage < ApplicationRecord
  belongs_to :detail
  has_attached_file :image,
                    :styles => {
                      :original =>  "665x420>"
                    }
  validates_attachment_content_type :image,
    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"],
    size: { in: 03..1000.kilobytes }
end
