class CreateSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.string :SeriesName, null: false
      t.string :TitleColor

      t.timestamps
    end
    add_index :series, [:SeriesName]
  end
end
