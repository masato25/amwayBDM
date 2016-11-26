class CreateMachines < ActiveRecord::Migration[5.0]
  def change
    create_table :machines do |t|
      t.string :name
      t.references :plain, foreign_key: true

      t.timestamps
    end
  end
end
