class AddAttachmentImageToFeatureImages < ActiveRecord::Migration
  def self.up
    change_table :feature_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :feature_images, :image
  end
end
