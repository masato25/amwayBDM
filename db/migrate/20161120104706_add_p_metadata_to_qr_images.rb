class AddPMetadataToQrImages < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key(:qr_images, :p_metadata, dependent: :delete)
  end
end
