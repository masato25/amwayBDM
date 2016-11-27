class CreatePlainDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :plain_details do |t|
      t.integer :ScreenIndex, null: false, default: 1
      t.string :TouchRect, null: false, default: "rect(0,0,0,0)"
      t.integer :detail_id
      t.integer :plain_id

      t.timestamps
    end
    add_foreign_key(:plain_details, :palins, dependent: :delete)
    add_foreign_key(:plain_details, :details, dependent: :delete)
    add_index :plain_details, [:plain_id, :detail_id], :unique => true
  end
end
