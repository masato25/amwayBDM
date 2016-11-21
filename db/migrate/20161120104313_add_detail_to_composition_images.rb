class AddDetailToCompositionImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :composition_images, :detail, foreign_key: true
  end
end
