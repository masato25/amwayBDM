class VideoPlain < ApplicationRecord
  validates :name, uniqueness: true
end
