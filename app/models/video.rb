class Video < ApplicationRecord
  belongs_to :video_plain
  has_attached_file :media, :url => "/media/:basename.:extension"
  validates_attachment_file_name :media, :matches => [/\.mp4\Z/, /\.avi\Z/, /\.mov\Z/]
  belongs_to :video_plain
end
