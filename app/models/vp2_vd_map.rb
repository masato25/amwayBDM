class Vp2VdMap < ApplicationRecord
  validates :video_plain_id, uniqueness: {scope: [:screen, :video_id]}

  def video
    Video.find(self["video_id"])
  end

end
