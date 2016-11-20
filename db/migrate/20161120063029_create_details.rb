class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.string :detail
      t.boolean :IsShow
      t.string :DetailName
      t.text :Feature
      t.text :HealthyFeature
      t.text :HealthyTip

      t.timestamps
    end
  end
end
