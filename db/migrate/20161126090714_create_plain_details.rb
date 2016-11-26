class CreatePlainDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :plain_details do |t|
      t.integer :screen, null: false
      t.string :coordinate
      t.integer :detail_id
      t.integer :plain_id

      t.timestamps
    end
    add_foreign_key(:plain_details, :palins, dependent: :delete)
    add_foreign_key(:plain_details, :details, dependent: :delete)
    add_index :plain_details, [:plain_id, :detail_id], :unique => true
  end
end
