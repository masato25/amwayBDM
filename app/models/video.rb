class Video < ApplicationRecord
  include Rails.application.routes.url_helpers
  # belongs_to :video_plain
  has_many :vp2_vd_maps, :dependent => :destroy

  has_attached_file :media, :url => "/media/:basename.:extension"
  do_not_validate_attachment_file_type :media
  validates_attachment_file_name :media, :matches => [/\.mp4\Z/, /\.avi\Z/, /\.mov\Z/]
  validates_presence_of :media
  def to_jq_upload
    {
      "name"        => read_attribute(:name),
      "size"        => read_attribute(:size),
      "url"         => "/media/#{read_attribute(:filename)}"
    }
  end
  def initialize(params = {})
    @file = params.delete(:file)
    super
    if @file
      self.filename = sanitize_filename(@file.original_filename)
      self.content_type = @file.content_type
      self.file_contents = @file.read
    end
  end
end
