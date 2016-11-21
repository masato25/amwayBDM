class AddBrandToSeriess < ActiveRecord::Migration[5.0]
  def change
    add_reference :series, :brand, foreign_key: true
  end
end
