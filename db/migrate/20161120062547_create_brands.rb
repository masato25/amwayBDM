class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :BrandName

      t.timestamps
    end
  end
end
