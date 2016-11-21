class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :mtype
      t.integer :refer_id

      t.timestamps
    end
  end
end
