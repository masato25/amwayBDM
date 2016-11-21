class AddAttachmentImageToCompositionImages < ActiveRecord::Migration
  def self.up
    change_table :composition_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :composition_images, :image
  end
end
