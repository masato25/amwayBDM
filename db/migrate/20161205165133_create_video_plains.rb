class CreateVideoPlains < ActiveRecord::Migration[5.0]
  def change
    create_table :video_plains do |t|
      t.string :name

      t.timestamps
    end
  end
end
