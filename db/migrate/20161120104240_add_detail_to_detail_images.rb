class AddDetailToDetailImages < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key(:detail_images, :detail, dependent: :delete)
  end
end
