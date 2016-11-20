class CreatePMetadata < ActiveRecord::Migration[5.0]
  def change
    create_table :p_metadata do |t|
      t.string :pmetadata
      t.string :SN
      t.string :Volume
      t.integer :Price
      t.string :Color

      t.timestamps
    end
  end
end
