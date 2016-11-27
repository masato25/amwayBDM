class CreateMachines < ActiveRecord::Migration[5.0]
  def change
    create_table :machines do |t|
      t.string :name
      t.integer :plain_id, :default => 0
      t.timestamps
    end
  end
end
