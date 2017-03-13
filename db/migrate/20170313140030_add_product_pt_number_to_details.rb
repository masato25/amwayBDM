class AddProductPtNumberToDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :details, :ProductPtNumber, :string
  end
end
