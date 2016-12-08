class CreateContentImages < ActiveRecord::Migration[5.0]
  def change
    create_table :content_images do |t|
      t.integer :detail_id

      t.timestamps
    end
    add_foreign_key(:content_images, :detail, dependent: :delete)
  end
end
