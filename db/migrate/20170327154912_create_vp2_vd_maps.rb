class CreateVp2VdMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :vp2_vd_maps do |t|
      t.integer :screen
      t.references :video_plain, index: false, foreign_key: {on_delete: :cascade}
      t.references :video, index: false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end

    # add_index :vp2_vd_maps, [:video_plains_id, :videos_id, :screen], :unique => true
    #add_foreign_key :vp2_vd_maps, :video_plains, index: false, on_delete: :cascade
    #add_foreign_key :vp2_vd_maps, :videos, index: false, on_delete: :cascade
  end
end
