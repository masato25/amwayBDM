class AddDetailToCompositionImages < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key(:composition_images, :detail, dependent: :delete)
  end
end
