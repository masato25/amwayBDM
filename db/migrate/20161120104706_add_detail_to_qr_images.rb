class AddDetailToQrImages < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key(:qr_images, :detail, dependent: :delete)
  end
end
