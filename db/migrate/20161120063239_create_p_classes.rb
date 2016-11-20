class CreatePClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :p_classes do |t|
      t.string :SNColor

      t.timestamps
    end
  end
end
