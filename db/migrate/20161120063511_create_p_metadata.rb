class CreatePMetadata < ActiveRecord::Migration[5.0]
  def change
    create_table :p_metadata do |t|
      t.string :SN, null: false
      t.string :Volume, null: false
      t.integer :Price, null: false
      t.string :Color

      t.timestamps
    end
  end
end
