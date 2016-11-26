class AddBrandToSeriess < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key(:series, :brands, dependent: :delete)
  end
end
