class AddSeriesIdToDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :details, :seriesID, :integer
  end
end
