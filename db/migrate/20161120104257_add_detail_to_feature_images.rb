class AddDetailToFeatureImages < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key(:feature_images, :detail, dependent: :delete)
  end
end
