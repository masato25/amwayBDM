class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :photo
      t.string :type
      t.integer :referid

      t.timestamps
    end
  end
end