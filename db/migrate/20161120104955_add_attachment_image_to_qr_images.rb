class AddAttachmentImageToQrImages < ActiveRecord::Migration
  def self.up
    change_table :qr_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :qr_images, :image
  end
end
