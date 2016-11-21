class CreateFeatureImages < ActiveRecord::Migration[5.0]
  def change
    create_table :feature_images do |t|

      t.timestamps
    end
  end
end
