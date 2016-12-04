class Backup < ApplicationRecord
  has_attached_file :avatar, :url => "/backups/:basename.:extension"
  validates_attachment_file_name :avatar, :matches => [/tar.gz\Z/]
  validates :avatar_file_name, uniqueness: true
end
