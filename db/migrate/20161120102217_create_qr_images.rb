class CreateQrImages < ActiveRecord::Migration[5.0]
  def change
    create_table :qr_images do |t|

      t.timestamps
    end
  end
end
