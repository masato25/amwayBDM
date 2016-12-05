class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.references :video_plain, foreign_key: true
      t.integer :screen

      t.timestamps
    end
  end
end
