class SeriesBackgroundImage < ApplicationRecord
  belongs_to :series
  has_attached_file :image,
                    :styles => {
                      :original =>  "1920x1080>"
                    }
  validates_attachment_content_type :image,
    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"],
    size: { in: 03..3000.kilobytes }
end
