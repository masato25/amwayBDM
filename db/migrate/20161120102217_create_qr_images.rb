class CreateQrImages < ActiveRecord::Migration[5.0]
  def change
    create_table :qr_images do |t|
      t.integer :p_metadata_id
      t.timestamps
    end
  end
end
