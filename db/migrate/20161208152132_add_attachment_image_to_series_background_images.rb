class AddAttachmentImageToSeriesBackgroundImages < ActiveRecord::Migration
  def self.up
    change_table :series_background_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :series_background_images, :image
  end
end
