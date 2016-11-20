class AddBrandIdToSeries < ActiveRecord::Migration[5.0]
  def change
    add_column :series, :brandID, :integer
  end
end
