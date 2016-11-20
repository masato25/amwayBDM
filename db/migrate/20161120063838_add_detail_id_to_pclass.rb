class AddDetailIdToPclass < ActiveRecord::Migration[5.0]
  def change
    add_column :p_classes, :detailID, :integer
  end
end
