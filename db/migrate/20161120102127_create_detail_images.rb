class CreateDetailImages < ActiveRecord::Migration[5.0]
  def change
    create_table :detail_images do |t|

      t.timestamps
    end
  end
end
