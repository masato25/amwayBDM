class AddDetailToDetailImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :detail_images, :detail, foreign_key: true
  end
end
