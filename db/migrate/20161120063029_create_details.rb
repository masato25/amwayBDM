class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.boolean :IsShow, null: false, :default => true
      t.string :DetailName, null: false
      t.text :Feature
      t.text :HealthyFeature
      t.text :HealthyTip
      t.string :SNColor
      t.integer :series_id

      t.timestamps
    end
  end
end
