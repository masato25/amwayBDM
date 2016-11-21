class AddPMetadataToQrImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :qr_images, :metadata, foreign_key: true
  end
end
