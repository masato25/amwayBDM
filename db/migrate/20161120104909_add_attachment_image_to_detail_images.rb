class AddAttachmentImageToDetailImages < ActiveRecord::Migration
  def self.up
    change_table :detail_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :detail_images, :image
  end
end
