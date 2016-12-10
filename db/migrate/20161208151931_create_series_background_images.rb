class CreateSeriesBackgroundImages < ActiveRecord::Migration[5.0]
  def change
    create_table :series_background_images do |t|
      t.integer :series_id, foreign_key: true

      t.timestamps
    end
    add_foreign_key(:series_background_images, :series, dependent: :delete)
  end
end
