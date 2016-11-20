class CreateSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.string :series
      t.string :SeriesName
      t.string :TitleColor

      t.timestamps
    end
  end
end
