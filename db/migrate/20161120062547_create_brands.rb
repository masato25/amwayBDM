class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :BrandName, null: false, :unique => true

      t.timestamps
    end
    add_index :brands, [:BrandName], :unique => true
  end
end
