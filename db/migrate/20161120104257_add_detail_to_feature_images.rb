class AddDetailToFeatureImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :feature_images, :detail, foreign_key: true
  end
end
