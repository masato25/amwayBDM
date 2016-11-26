class CreatePMetadata < ActiveRecord::Migration[5.0]
  def change
    create_table :p_metadata do |t|
      t.string :SN, null: false
      t.string :Volume
      t.integer :Price
      t.string :Color
      t.integer :detail_id

      t.timestamps
    end
  end
end
